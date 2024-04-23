{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nerdfonts
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    ubuntu_font_family
    font-awesome
  ];
}