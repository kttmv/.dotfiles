{ config, pkgs, ... }:

{
  imports = [
    ./home/wm/default.nix
    ./home/nixvim/default.nix
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Breeze-Dark";
      package = pkgs.libsForQt5.breeze-gtk;
    };
    font.name = "Ubuntu";
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  home.username = "vlad";
  home.homeDirectory = "/home/vlad";

  home.packages = with pkgs; [ lf ];

  home.file = {
    ".config/fish" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/fish";
    };
    ".config/helix" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/helix";
    };
    ".config/kitty" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/kitty";
    };
    ".config/swaync" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/swaync";
    };
    ".config/wlogout" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/wlogout";
    };
    ".config/wofi" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/wofi";
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  programs.home-manager.enable = true;

  home.stateVersion = "23.11"; # Do not change
}
