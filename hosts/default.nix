let
  hosts = map import (import ./registry.nix);
in
  builtins.listToAttrs (map (host: {
      inherit (host) name;
      value = removeAttrs host ["name"];
    })
    hosts)
