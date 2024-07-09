{ config, ... }:

{
  imports = [
    ./packages.nix
    ./gtk/default.nix
    ./wm/default.nix
    ./nixvim/default.nix
  ];

  home.username = "vlad";
  home.homeDirectory = "/home/vlad";

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
