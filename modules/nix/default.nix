{
  config,
  lib,
  inputs,
  ...
}: {
  options.appsmith.nix = {
    allowUnfree = lib.mkEnableOption "'unfree' packages";

    stateVersion = lib.mkOption {
      example = "23.11";
    };
  };

  config = {
    system = {
      inherit (config.appsmith.nix) stateVersion;
    };

    nix = {
      # add each flake input as a registry to make nix3 commands consistent with your flake
      registry = lib.mapAttrs (_: value: {flake = value;}) (lib.filterAttrs (n: _: n != "self") inputs);

      # add inputs to the system's legacy channels, making legacy nix commands consistent too
      nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

      # enable modern features and de-duplicate store during install
      settings = {
        auto-optimise-store = lib.mkDefault true;
        experimental-features = ["nix-command" "flakes"];
        trusted-users = ["root" "@wheel"];
      };

      # automatic garbage collection, weekly by default
      gc = {
        automatic = lib.mkDefault true;
        dates = lib.mkDefault "weekly";
      };
    };

    nixpkgs.config = {
      inherit (config.appsmith.nix) allowUnfree;
    };
  };
}
