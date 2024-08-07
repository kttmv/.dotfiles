{ pkgs, mongodb-pkgs, ... }:

let
  packagesList = with pkgs; [
    # CLI
    lf # file browser
    zellij # tmux killer
    nh # nix cli helper 
    ripgrep # regex search tool, used in telescope
    wget # tool for downloading files

    pavucontrol # audio control panel

    obsidian # notes on steroids

    okular # pdf reader
    onlyoffice-bin # office alternative
    pinta # paint alternative

    webcord # electron wrapper for web version of discrod

    # BROWSERS
    firefox # not so evil browser
    microsoft-edge-dev # an evil browser
  ];
  packagesListMongoDB = with mongodb-pkgs; [ mongodb mongosh ];
  packagesListDev = with pkgs; [
    # EDITORS
    helix # vim killer (?)
    vscode # an evil code editor

    # GIT
    git
    lazygit # nice terminal ui for git
    gh # github

    # DOTNET
    (with dotnetCorePackages; combinePackages [
      sdk_6_0
      sdk_7_0
      sdk_8_0
    ])
    dotnetPackages.Nuget

    # LANGUAGES
    gcc
    nodePackages_latest.nodejs
    nodePackages_latest."@nestjs/cli"
    python3
    rustup

    # FORMATTERS
    csharpier # an opinionated code formatter for C#
    nixpkgs-fmt # nix language formatter
  ];
in
{
  home.packages = packagesList ++ packagesListMongoDB ++ packagesListDev;
}
