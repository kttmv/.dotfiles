{ config, pkgs, ... }:

{
  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/mnt/c" = {
    device = "/dev/nvme0n1p3";
    fsType = "ntfs";
  };
}
