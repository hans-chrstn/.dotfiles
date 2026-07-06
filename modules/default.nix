let
  mkModules = path: let
    dir = builtins.readDir path;
    entries = builtins.filter (
      n:
        dir.${n}
        == "directory"
        || (dir.${n} == "regular" && n != "default.nix" && builtins.match ".*\\.nix$" n != null)
    ) (builtins.attrNames dir);

    getName = n:
      if dir.${n} == "directory"
      then n
      else builtins.substring 0 (builtins.stringLength n - 4) n;
  in
    builtins.listToAttrs (map (n: {
        name = getName n;
        value = import (path + "/${n}");
      })
      entries);
in {
  nixos = mkModules ./nixos;
  home-manager = mkModules ./home-manager;
}
