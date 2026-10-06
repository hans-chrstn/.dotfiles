#!@shell@
# Launcher for Irony Mod Manager. See the postFixup comment in default.nix for
# why the app is mirrored into $XDG_DATA_HOME instead of exec'd from the store.
set -eu

store_app="@app@"
data_dir="${XDG_DATA_HOME:-$HOME/.local/share}/irony-mod-manager"
app_dir="$data_dir/app"
stamp="$app_dir/.nix-store-path"

# Rebuild the mirror whenever the package changes; the stamp holds the store
# path it was built from. State lives in $data_dir's other subdirectories
# (StoragePath), so blowing away just $app_dir keeps collections and settings.
if [ "$(cat "$stamp" 2>/dev/null || true)" != "$store_app" ]; then
    rm -rf "$app_dir"
    mkdir -p "$app_dir"

    for entry in "$store_app"/*; do
        name=${entry##*/}
        case $name in
        # Real copies (~17M all told):
        #  - IronyModManager* — the apphosts and the app's own assemblies.
        #    hostpolicy derives AppContext.BaseDirectory from the *resolved*
        #    path of the entry assembly, not from /proc/self/exe, so leaving
        #    IronyModManager.dll as a symlink silently snaps BaseDirectory
        #    (and with it Program.Main's chdir) back into the store and
        #    defeats the whole mirror. Copying every IronyModManager* file
        #    rather than just that one also keeps the DI assembly scanner
        #    and anything else reading Assembly.Location inside the mirror.
        #  - Databases — File.Copy propagates this mode to each seeded
        #    launcher DB; this is the file the mirror exists for.
        #  - appSettings.json — sits alongside them, cheap to keep writable.
        IronyModManager* | createdump | Databases | appSettings.json)
            cp -R "$entry" "$app_dir/$name"
            chmod -R u+w "$app_dir/$name"
            ;;
        *)
            ln -s "$entry" "$app_dir/$name"
            ;;
        esac
    done

    printf '%s' "$store_app" >"$stamp"
fi

export LD_LIBRARY_PATH="@libraryPath@${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

exec "$app_dir/IronyModManager" "$@"
