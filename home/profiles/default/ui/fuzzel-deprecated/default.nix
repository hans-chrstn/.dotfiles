{  inputs, outputs, lib, pkgs, ... }:

{

  imports = [

  ];

  home.file.".config/fuzzel" = {
    source = ./config;


  };  
}
