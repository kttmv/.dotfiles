{ config, pkgs, ... }:

{
  services = {
    printing.enable = true;
    power-profiles-daemon.enable = false;

    tlp = {
      enable = true;
      settings = {
        CPU_BOOST_ON_AC = 0;
        CPU_BOOST_ON_BAT = 0;
      };
    };
  };
}
