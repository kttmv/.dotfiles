{
  description = "My first flake!";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";


    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nixvim, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

    in
    {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;

          modules = [ ./configuration.nix ];
        };
      };

      homeConfigurations = {
        vlad = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [ ./home/default.nix nixvim.homeManagerModules.nixvim ];
        };
      };
    };
}
