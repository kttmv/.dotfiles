{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    vendor.functions.enable = true;
    vendor.completions.enable = true;
    interactiveShellInit =
      let
        fishline = pkgs.fetchFromGitHub {
          owner = "0rax";
          repo = "fishline";
          rev = "4b611b7";
          sha256 = "sha256-NYKzHbrRjZ6xYQRw8tN7dl2ySkey8vr9dBegv+C2JEg=";
        };
      in
      ''
        set FLINE_PATH ${fishline}
        source $FLINE_PATH/init.fish
        eval (zellij setup --generate-auto-start fish | string collect)
        zoxide init fish | source
      '';
    promptInit = ''
      function fish_prompt
        fishline -s $status
      end
    '';
  };

  users.defaultUserShell = pkgs.fish;

  environment.systemPackages = with pkgs; [
    powerline
    zoxide # a smarter cd command
  ];
}
