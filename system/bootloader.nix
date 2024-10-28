{ config, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # workaround for this weird issue https://discourse.nixos.org/t/nixos-rebuild-switch-upgrade-networkmanager-wait-online-service-failure/30746
  # todo: delete this sometime in the future when it is fixed
  systemd.services.NetworkManager-wait-online.enable = false;
}
