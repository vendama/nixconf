{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ...
  } @ inputs: {
    nixosConfigurations.mercury =
      nixpkgs.lib.nixosSystem
      {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          inputs.disko.nixosModules.disko
          ./configuration.nix
          ./hosts/mercury/configuration.nix
          ./hosts/mercury/hardware-configuration.nix
          ./hosts/mercury/disko.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;

              users.vendama = ./hosts/mercury/home.nix;
            };
          }
          {
            # This makes pkgs.unstable.PACKAGENAME available
            nixpkgs.overlays = [
              (final: prev: {
                unstable = nixpkgs-unstable.legacyPackages.${prev.system};
              })
            ];
          }
        ];
      };
    nixosConfigurations.gemini =
      nixpkgs.lib.nixosSystem
      {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          inputs.disko.nixosModules.disko
          ./configuration.nix
          ./hosts/gemini/configuration.nix
          ./hosts/gemini/hardware-configuration.nix
          ./hosts/gemini/disko.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;

              users.vendama = ./hosts/gemini/home.nix;
            };
          }
          {
            nixpkgs.overlays = [
              (final: prev: {
                unstable = nixpkgs-unstable.legacyPackages.${prev.system};
              })
            ];
          }
        ];
      };
  };
}
