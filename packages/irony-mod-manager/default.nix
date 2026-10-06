{
  lib,
  stdenv,
  fetchurl,
  fetchzip,
  autoPatchelfHook,
  makeDesktopItem,
  copyDesktopItems,
  jq,
  fontconfig,
  zlib,
  icu,
  openssl,
  krb5,
  glib,
  gtk3,
  libx11,
  libice,
  libsm,
  libxcursor,
  libxext,
  libxi,
  libxrandr,
  wayland,
  libxkbcommon,
  libevdev,
  libglvnd,
  ...
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "irony-mod-manager";
  version = "1.27.206";

  # fetchzip rather than a plain fetchurl + unzip: the release zip is a flat
  # archive with no root directory, so unpacking it in-place would make the
  # build root the source root and `cp -r .` would sweep stdenv's own env-vars
  # file into the output — dragging the whole build-time stdenv (~400M of gcc)
  # into the runtime closure.
  src = fetchzip {
    url = "https://github.com/bcssov/IronyModManager/releases/download/v${finalAttrs.version}/linux-x64.zip";
    hash = "sha256-ephwzPfFI6oeRTah++mxET5/p21ynwv50zwYRXoWqWs=";
    stripRoot = false;
  };

  # The app icon only exists as an embedded .NET resource in the shipped build;
  # take the source-tree copy so the desktop entry has something to point at.
  icon = fetchurl {
    url = "https://raw.githubusercontent.com/bcssov/IronyModManager/v${finalAttrs.version}/src/IronyModManager/Assets/logo.png";
    hash = "sha256-OYayhqZa3YCLzZvmllAeaFxO5xKywlE5RJuygiY+fkc=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    copyDesktopItems
    jq
  ];

  # Only what the ELFs actually list as NEEDED — this is a self-contained .NET
  # build, so the runtime itself is bundled. Everything Avalonia and CoreCLR
  # reach for via dlopen goes through LD_LIBRARY_PATH in the wrapper instead.
  buildInputs = [
    stdenv.cc.cc.lib
    fontconfig
    zlib
  ];

  # libcoreclrtraceptprovider.so is CoreCLR's optional LTTng tracing shim. It
  # wants liblttng-ust.so.0, which only nixpkgs' 2.12 series still provides;
  # CoreCLR dlopens it lazily and carries on when it's absent, so leave the
  # dangling NEEDED rather than pin an EOL tracer into the closure.
  autoPatchelfIgnoreMissingDeps = ["liblttng-ust.so.0"];

  dontConfigure = true;
  dontBuild = true;

  # Three upstream defaults are wrong for a store-resident install:
  #
  # 1. StoragePath is resolved with Path.GetFullPath(path, BaseDirectory)
  #    (IronyModManager.IO.Common/DiskOperations.cs), so upstream's relative
  #    "Mario" — and the release zip's "$HOME/.config/Mario" — either land in
  #    the read-only store or in a non-XDG spot. Every writable path (config,
  #    logs, updater scratch) funnels through that one resolver, so pointing it
  #    at an absolute XDG data dir is enough to keep state out of the app dir.
  #    Path segments starting with '$' are expanded as env vars, so $HOME works
  #    without baking in a username.
  # 2. The in-app updater would try to overwrite the store. Nix owns the
  #    version here, so turn it off.
  # 3. With UseGameHandler set, ExternalProcessHandlerService.LaunchSteamAsync
  #    calls ProcessRunner.EnsurePermissions, which shells out to a hardcoded
  #    /bin/bash to chmod +x the game handler. NixOS has /bin/sh but no
  #    /bin/bash, so that throws Win32Exception(2) and takes the whole "launch
  #    game" pipeline down with it. Dropping to the legacy launch path skips
  #    EnsurePermissions entirely: LaunchSteamAsync then just checks whether a
  #    steam process is already up and otherwise opens steam:// via
  #    ProcessRunner.ShellExec, which uses /bin/sh and is fine here. The actual
  #    game launch goes through xdg-open either way — the game handler only
  #    ever existed to avoid binding the Steamworks API into the main process.
  postPatch = ''
    jq '.App.StoragePath = "$HOME/.local/share/irony-mod-manager"
        | .Updates.Disable = true
        | .Steam.UseGameHandler = false
        | .Steam.UseLegacyLaunchMethod = true' \
      appSettings.json > appSettings.json.new
    mv appSettings.json.new appSettings.json
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/irony-mod-manager
    cp -r . $out/share/irony-mod-manager

    # IronyModManager.GameHandler (Steam launching) and IronyModManager.Updater
    # are spawned by path relative to the main binary, so the whole directory
    # has to stay intact — only the entrypoint gets exposed.
    chmod +x $out/share/irony-mod-manager/IronyModManager \
             $out/share/irony-mod-manager/IronyModManager.GameHandler \
             $out/share/irony-mod-manager/IronyModManager.Updater \
             $out/share/irony-mod-manager/createdump

    install -Dm644 $icon $out/share/icons/hicolor/256x256/apps/irony-mod-manager.png

    runHook postInstall
  '';

  # Avalonia resolves X11/GTK/Wayland through DllImport and CoreCLR resolves
  # ICU, OpenSSL and Kerberos through dlopen — none of which autoPatchelfHook
  # can see, since none appear as NEEDED entries. libGL plus the runtime driver
  # dir are for Skia's GPU backend.
  #
  # Irony cannot simply be exec'd out of the store, hence a hand-written
  # launcher instead of makeWrapper. SQLiteExporter.EnsureDbExists seeds a
  # Paradox launcher DB it doesn't find with
  #   DiskOperations.CopyFile("Databases/empty_paradox_launcher.sqlite", db)
  # and that is a bare File.Copy, which on Unix carries the source's mode over
  # to the destination. Straight from the store the template is 0444, so the
  # seeded DB lands read-only and every "Apply collection" dies with SQLite
  # error 8, 'attempt to write a readonly database'. This is not an edge case:
  # ModWriter.ApplyModsAsync always runs the beta exporter alongside the normal
  # one, so launcher-v2_openbeta.sqlite gets seeded — and poisoned — on every
  # single apply, whether or not the launcher beta is in use.
  #
  # The template has to be writable, and it is looked up relative to the app
  # directory (Program.Main pins Environment.CurrentDirectory to
  # AppContext.BaseDirectory), so the app directory has to be writable. Mirror
  # it into $XDG_DATA_HOME instead of copying all 186M — see launcher.sh for
  # which entries have to be real files and why symlinking the wrong one puts
  # BaseDirectory back in the store.
  postFixup = ''
    mkdir -p $out/bin
    substitute ${./launcher.sh} $out/bin/irony-mod-manager \
      --subst-var-by app "$out/share/irony-mod-manager" \
      --subst-var-by shell "${stdenv.shell}" \
      --subst-var-by libraryPath "${
      lib.makeLibraryPath [
        icu
        openssl
        krb5
        fontconfig
        zlib
        glib
        gtk3
        libx11
        libice
        libsm
        libxcursor
        libxext
        libxi
        libxrandr
        wayland
        libxkbcommon
        libevdev
        libglvnd
      ]
    }:/run/opengl-driver/lib"
    chmod +x $out/bin/irony-mod-manager
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "irony-mod-manager";
      desktopName = "Irony Mod Manager";
      comment = "Mod manager for Paradox Clausewitz/Jomini engine games";
      exec = "irony-mod-manager";
      icon = "irony-mod-manager";
      terminal = false;
      categories = [
        "Game"
        "Utility"
      ];
      keywords = [
        "paradox"
        "mod"
        "ck3"
        "stellaris"
        "hoi4"
      ];
    })
  ];

  meta = {
    description = "Mod manager for Paradox Clausewitz/Jomini engine games (CK3, Stellaris, HOI4, EU4/V, Victoria 3)";
    homepage = "https://bcssov.github.io/IronyModManager/";
    changelog = "https://github.com/bcssov/IronyModManager/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.mit;
    platforms = ["x86_64-linux"];
    sourceProvenance = [lib.sourceTypes.binaryNativeCode];
    mainProgram = "irony-mod-manager";
  };
})
