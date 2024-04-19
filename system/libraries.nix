{ config, pkgs, lib, ... }:

let
  missing-gsettings-schemas-fix = builtins.readFile "${pkgs.stdenv.mkDerivation {
    name = "missing-gsettings-schemas-fix";
    dontUnpack = true; # Make it buildable without “src” attribute
    buildInputs = [ pkgs.gtk3 ];
    installPhase = '' printf %s "$GSETTINGS_SCHEMAS_PATH" > "$out" '';
  }}";
in
{
  # Fix for “No GSettings schemas are installed on the system” error
  # that causes Qt application to crash when opening file picker dialog window.
  environment.sessionVariables.XDG_DATA_DIRS = lib.mkAfter [ "${missing-gsettings-schemas-fix}" ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    alsaLib
    at-spi2-atk
    atk
    at-spi2-core
    cairo
    cups
    dbus
    expat
    fontconfig
    freetype
    gcc-unwrapped
    gdk-pixbuf
    glib
    gnome2.GConf
    gtk2
    gtk3
    gtk4
    libcap
    libdrm
    libgcc
    libGL
    libGLU
    libxkbcommon
    nspr
    nss
    mesa
    pango
    systemd
    xorg.libICE
    xorg.libSM
    xorg.libX11
    xorg.libxcb
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    xorg.libXScrnSaver
    xorg.libxshmfence
    xorg.libXt
    xorg.libXtst
  ];
}
