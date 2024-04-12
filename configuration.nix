{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/mnt/c" = {
    device = "/dev/nvme0n1p3";
    fsType = "ntfs";
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
    displayManager = {
      # gdm.enable = true;
      # lightdm.enable = true;
      sddm.enable = true;
    };
    desktopManager = {
      gnome.enable = true;
      # deepin.enable = true;
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };


  programs.fish = {
    enable = true;
    vendor.functions.enable = true;
    vendor.completions.enable = true;
    shellInit =
      let
        fishline = pkgs.fetchFromGitHub {
          owner = "0rax";
          repo = "fishline";
          rev = "4b611b7"; # replace with specific commit or tag as needed
          sha256 = "sha256-NYKzHbrRjZ6xYQRw8tN7dl2ySkey8vr9dBegv+C2JEg="; # replace with the correct hash
        };
      in
      ''
        set FLINE_PATH ${fishline}
        source $FLINE_PATH/init.fish
        zoxide init fish | source
      '';
    promptInit = ''
      function fish_prompt
        fishline -s $status
      end
    '';
  };
  users.defaultUserShell = pkgs.fish;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vlad = {
    isNormalUser = true;
    description = "Vlad";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ firefox ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    wget
    nodejs_21
    python3
    rustup
    nerdfonts
    ripgrep
    microsoft-edge-dev
    anytype
    gnome.gnome-tweaks
    xclip
    omnisharp-roslyn
    dotnetCorePackages.dotnet_8.sdk
    dotnetCorePackages.dotnet_8.runtime
    csharp-ls
    dotnetPackages.Nuget
    lazygit
    discord
    psensor
    cpufrequtils
    powerline
    gcc
    obsidian
    pinta
    onlyoffice-bin
    kitty
    waybar # bar for hyprland
    dunst # notification daemon for hyprland
    libnotify # dunst depends on it
    swww # wallpaper daemon for hyprland
    rofi-wayland # A window switcher, application launcher and dmenu replacement
    wofi # window switcher
    nil # nix language server
    nixpkgs-fmt
    zoxide
    okular # pdf reader
    hyprshot # screenshots for hyprland
    wineWowPackages.waylandFull
    webcord # electron wrapper for web version of discrod
    vscode
    gnome.nautilus # file manager
    gnome.gnome-calculator
    brightnessctl # a program to change brightness
    networkmanagerapplet # tray app to connect to wifi
  ];

  xdg.portal = {
    enable = true;
    # extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
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
    gtk3
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

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "23.11"; # Do not change

  networking.wg-quick.interfaces = {
    wg0.configFile = "/secret/wg0.conf";
  };

  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    # extraConfig = ''
    settings = {
      CPU_BOOST_ON_AC = 0;
      CPU_BOOST_ON_BAT = 0;
    };
  };
}
