{ pkgs, mongodb-pkgs, ... }:

let
  packagesList = with pkgs; [ lf pavucontrol ];
  packagesListMongoDB = with mongodb-pkgs; [ mongodb ];
in
{
  home.packages = packagesList ++ packagesListMongoDB;
}
