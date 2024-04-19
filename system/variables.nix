{ config, pkgs, ... }:

{
  environment.variables = rec {
    FLAKE = ".dotfiles";
  };
}
