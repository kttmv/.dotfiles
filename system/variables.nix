{ config, pkgs, ... }:

{
  environment.sessionVariables = rec {
    FLAKE = "~/.dotfiles";
  };
}
