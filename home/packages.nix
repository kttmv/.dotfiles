{ pkgs, ... }:

let
  packagesList = with pkgs; [
    kitty # terminal emulator
    warp-terminal # an intelligent? terminal

    # CLI
    lf # file browser
    zellij # tmux killer
    nh # nix cli helper 
    ripgrep # regex search tool, used in telescope
    wget # tool for downloading files

    pavucontrol # audio control panel

    obsidian # notes on steroids

    okular # pdf reader
    peazip # winrar/7zip alternative
    onlyoffice-bin # office alternative
    pinta # paint alternative

    webcord # electron wrapper for web version of discrod

    gnome-calculator # calculator
    cinnamon.nemo # file manager

    # BROWSERS
    firefox # not so evil browser
    microsoft-edge-dev # an evil browser
  ];
  packagesListDev = with pkgs; [
    # EDITORS
    helix # vim killer (?)
    vscode # an evil code editor
    zed-editor # vscode killer

    # GIT
    lazygit # nice terminal ui for git
    gh # github

    # DOTNET
    #(with dotnetCorePackages; combinePackages [
    #sdk_6_0
    #sdk_7_0
    #sdk_8_0
    #])
    #dotnetPackages.Nuget

    # LANGUAGES
    gcc
    nodePackages_latest.nodejs
    python3
    rustup

    # FORMATTERS
    csharpier # an opinionated code formatter for C#
    nixpkgs-fmt # nix language formatter
  ];
  packagesListWM = with pkgs; [
    swaynotificationcenter
    swww # wallpaper daemon
    wofi # application launcher
    rofi # application launcher, used for password prompt
    brightnessctl # a program to change brightness
    networkmanagerapplet # tray app to connect to wifi
    hyprshot # screenshots for hyprland
    hyprlock # screen locking utility
    wlogout # logout menu
    wl-clip-persist # to keep Wayland clipboard after programs close
    wl-clipboard # required by cliphist
    cliphist # clipboard manager
  ];
in
{
  home.packages = packagesList ++ packagesListDev ++ packagesListWM;
}
