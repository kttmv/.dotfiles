{
  description = "My first flake!";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    nixpkgs-mongodb.url = "nixpkgs/9f4128e00b0ae8ec65918efeba59db998750ead6";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-mongodb, home-manager, nixvim, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

    in
    {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;

          # specialArgs = {
            # mongodb-pkgs = import nixpkgs-mongodb {
              # inherit system;
              # config.allowUnfree = true;
            # };
          # };

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
