{  inputs, outputs, lib, pkgs, ... }:

{

  imports = [

  ];

  home.file.".config/hypr" = {
    source = ./config;


  };  
}
