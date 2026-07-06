let
  # Get all category directories
  categories = builtins.filter (c: (builtins.readDir ./.).${c} == "directory") (builtins.attrNames (builtins.readDir ./.));

  # Dynamically build an attribute set of all modules that contain a specific file (nixos.nix or home.nix)
  getModulesOfType = typeFile:
    builtins.foldl' (
      acc: cat: let
        catDir = builtins.readDir (./. + "/${cat}");
        modules = builtins.filter (m: catDir.${m} == "directory" && builtins.pathExists (./. + "/${cat}/${m}/${typeFile}")) (builtins.attrNames catDir);
        moduleSet = builtins.listToAttrs (map (m: {
            name = m;
            value = import (./. + "/${cat}/${m}/${typeFile}");
          })
          modules);
      in
        acc // moduleSet
    ) {}
    categories;
in {
  nixos = getModulesOfType "nixos.nix";
  home-manager = getModulesOfType "home.nix";
}
