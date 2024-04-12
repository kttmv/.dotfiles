{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };


  environment.systemPackages = with pkgs; [
    xclip # clipboard interface
    ripgrep # regex search tool, used in telescope
    csharp-ls # c# lsp
    nil # nix language server
    nixpkgs-fmt # nix language formatter
  ];
}
