{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, spicetify-nix, ... }@inputs:
  let
    mkHost = hostname: system: username: homeProfile: nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/${hostname}
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            inherit spicetify-nix;
            inherit inputs;
          };
          home-manager.users.${username} = import homeProfile;
        }
      ];
    };

  in
  {
    nixosConfigurations = {
      tbook = mkHost "tbook" "x86_64-linux" "gfors" ./home/profiles/tbook.nix;
      };
  };
}
