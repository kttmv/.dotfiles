{ config, pkgs, ... }:

{
  networking.wg-quick.interfaces = {
    wg0.configFile = "/secret/wg0.conf";
  };
}
