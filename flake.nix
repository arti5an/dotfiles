{
  description = "My NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland/v0.40.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    anyrun = {
      url = "github:anyrun-org/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:arti5an/ragenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ...
  } @ inputs: let
    commonModules = [
      home-manager.nixosModule
      ./modules
    ];
    nixosSystem = system: name: let
      inherit (import nixpkgs {inherit system;}) lib;
      pkgs-unstable = import nixpkgs-unstable {inherit system;};
    in
      nixpkgs.lib.nixosSystem {
        inherit lib system;
        specialArgs = {inherit inputs pkgs-unstable;};
        modules = commonModules ++ [./hosts/${name}];
      };
    forAllSystems = fn: (nixpkgs.lib.genAttrs ["aarch64-linux" "x86_64-linux"] fn);
  in {
    nixosConfigurations = {
      bifrost = nixosSystem "aarch64-linux" "bifrost";
      gamora = nixosSystem "x86_64-linux" "gamora";
      wsl = nixosSystem "x86_64-linux" "wsl";
    };

    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
  };
}
