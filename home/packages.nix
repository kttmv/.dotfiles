{ pkgs, mongodb-pkgs, ... }:

let
  packagesList = with pkgs; [
    lf # cli file browser
    zellij # tmux killer
    nh # nix cli helper 

    pavucontrol # audio control panel

    obsidian # notes on steroids

    okular # pdf reader
    onlyoffice-bin # office alternative
    pinta # paint alternative

    webcord # electron wrapper for web version of discrod

    firefox # not so evil browser
    microsoft-edge-dev # an evil browser

    #############################
    # DEV
    #############################

    helix # vim killer (?)
    vscode # an evil code editor

    git
    lazygit # nice terminal ui for git
    gh # github

    # different dotnet core versions
    (with dotnetCorePackages; combinePackages [
      sdk_6_0
      sdk_7_0
      sdk_8_0
    ])
    dotnetPackages.Nuget
    csharpier # an opinionated code formatter for C#

    gcc
    nodePackages_latest.nodejs
    nodePackages_latest."@nestjs/cli"
    python3
    rustup
    wget
  ];
  packagesListMongoDB = with mongodb-pkgs; [ mongodb ];
in
{
  home.packages = packagesList ++ packagesListMongoDB;
}
