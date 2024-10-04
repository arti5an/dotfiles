{
  description = "My NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    ...
  } @ inputs: let
    commonModules = [
      home-manager.nixosModule
      ./modules
    ];
    nixosSystem = system: name: let
      inherit (import nixpkgs {inherit system;}) lib;
      pkgs-stable = import nixpkgs-stable {inherit system;};
    in
      nixpkgs.lib.nixosSystem {
        inherit lib system;
        specialArgs = {inherit inputs pkgs-stable;};
        modules = commonModules ++ [./hosts/${name}];
      };
    supportedSystems = ["aarch64-linux" "x86_64-linux"];
    forAllSystems = fn: (nixpkgs.lib.genAttrs supportedSystems fn);
  in {
    nixosConfigurations = {
      bifrost = nixosSystem "aarch64-linux" "bifrost";
      gamora = nixosSystem "x86_64-linux" "gamora";
      wsl = nixosSystem "x86_64-linux" "wsl";
    };

    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
  };
}
