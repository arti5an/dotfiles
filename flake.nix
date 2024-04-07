{
  description = "My NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    commonModules = [
      home-manager.nixosModule
      ./modules
    ];
    nixosSystem = system: name: let
      inherit (import nixpkgs {inherit system;}) lib;
    in
      nixpkgs.lib.nixosSystem {
        inherit lib system;
        specialArgs = {inherit inputs;};
        modules = commonModules ++ [./hosts/${name}];
      };
    forAllSystems = fn: (nixpkgs.lib.genAttrs ["aarch64-linux" "x86_64-linux"] fn);
  in {
    nixosConfigurations = {
      gamora = nixosSystem "x86_64-linux" "gamora";
    };

    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
  };
}
