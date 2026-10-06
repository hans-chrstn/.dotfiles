{
  bubblewrap,
  coreutils,
  steam-run,
  cargo,
  lib,
  meson,
  ninja,
  pkg-config,
  python3,
  qt6,
  rustc,
  rustPlatform,
  sqlite,
  _7zip-zstd-rar,
  fetchFromGitHub,
}: let
  src = fetchFromGitHub {
    owner = "ChrisDKN";
    repo = "Amethyst-Mod-Manager";
    rev = "v2.4.3";
    hash = "sha256-3xNEJRTTG700b1OZWYraAryEsqKYbAzXTZ7VIbQZx/I=";
  };
  liblootSrc = fetchFromGitHub {
    owner = "loot";
    repo = "libloot";
    rev = "0.29.6";
    hash = "sha256-Pz13z0uQfTeo47NJORfZ8n8ucqZdoLVGNIsrf2+OOGA=";
  };
  libloot = python3.pkgs.buildPythonPackage {
    pname = "libloot";
    version = "0.29.6";
    pyproject = true;
    src = liblootSrc;
    sourceRoot = "source/python";
    cargoRoot = "..";

    cargoDeps = rustPlatform.importCargoLock {
      lockFile = "${liblootSrc}/Cargo.lock";
    };
    env.CARGO_TARGET_DIR = "target";

    nativeBuildInputs = with rustPlatform; [
      cargoSetupHook
      maturinBuildHook
    ];

    pythonImportsCheck = ["loot"];
  };
  pythonDeps =
    (with python3.pkgs; [
      bsdiff4
      certifi
      cryptography
      jeepney
      keyring
      lz4
      msgpack
      pillow
      py7zr
      pyside6
      requests
      secretstorage
      shiboken6
      zstandard
    ])
    ++ [libloot];
in
  python3.pkgs.buildPythonApplication {
    pname = "amethyst-mod-manager";
    version = "2.4.3";
    pyproject = false;
    inherit src;

    cargoDeps = rustPlatform.importCargoLock {
      lockFile = "${src}/native/amethyst_filegraph/Cargo.lock";
    };
    cargoRoot = "native/amethyst_filegraph";

    nativeBuildInputs = [
      cargo
      meson
      ninja
      pkg-config
      qt6.wrapQtAppsHook
      rustc
      rustPlatform.cargoSetupHook
    ];

    buildInputs = [
      qt6.qtbase
      qt6.qtwayland
      sqlite
    ];

    dependencies = pythonDeps;

    postPatch = ''
      patchShebangs src/version.py
      substituteInPlace amethyst-mod-manager amethyst-mod-manager-cli \
        --replace-fail 'exec python3' 'exec ${python3.interpreter}'
      substituteInPlace src/Nexus/nxm_handler.py \
        --replace-fail "return f'{cls._quote_if_needed(exe)} {cls._quote_if_needed(script)} --nxm %u'" 'return "amethyst-mod-manager --nxm %u"'
      substituteInPlace src/Utils/config_paths.py \
        --replace-fail 'return [sys.executable, str(cli_py)]' 'return ["amethyst-mod-manager-cli"]'
      substituteInPlace src/Utils/vfs/_selftest.py src/Utils/vfs/overlay.py \
        --replace-fail '"/bin/true"' '"true"'
      substituteInPlace src/Utils/launchers/steam.py \
        --replace-fail 'if _process_has_open_path(pid, pipe_file):' 'if True:'
    '';

    preConfigure = ''
      export LIBSQLITE3_SYS_USE_PKG_CONFIG=1
      export CARGO_TARGET_DIR=$PWD/native/amethyst_filegraph/target
      cargo build --frozen --release --all-features \
        --manifest-path native/amethyst_filegraph/Cargo.toml
      cp "$CARGO_TARGET_DIR/release/libamethyst_filegraph.so" \
        src/amethyst_filegraph.abi3.so
    '';

    dontWrapPythonPrograms = true;
    dontWrapQtApps = true;
    postFixup = ''
      for program in amethyst-mod-manager amethyst-mod-manager-cli; do
        wrapProgram "$out/bin/$program" \
          --prefix PYTHONPATH : "$out/${python3.sitePackages}:${python3.pkgs.makePythonPath pythonDeps}" \
          --prefix PATH : "${lib.makeBinPath [ bubblewrap python3 coreutils _7zip-zstd-rar ]}" \
          "''${qtWrapperArgs[@]}"
          
        # Rename the wrapper created by wrapProgram so we don't overwrite the original script
        mv "$out/bin/$program" "$out/bin/$program-wrapped-fhs"
        cat <<EOF > "$out/bin/$program"
#!/usr/bin/env bash
exec ${steam-run}/bin/steam-run "$out/bin/$program-wrapped-fhs" "\$@"
EOF
        chmod +x "$out/bin/$program"
      done
    '';

    pythonImportsCheck = [
      "amethyst_filegraph"
      "app_bootstrap"
      "loot"
    ];

    meta = {
      description = "Linux native mod manager for a variety of games";
      homepage = "https://github.com/ChrisDKN/Amethyst-Mod-Manager";
      license = lib.licenses.gpl3Only;
      mainProgram = "amethyst-mod-manager";
      platforms = lib.platforms.linux;
    };
  }
