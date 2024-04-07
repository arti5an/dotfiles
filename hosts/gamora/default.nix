{inputs, ...}: {
  imports = with inputs.nixos-hardware.nixosModules; [
    # Official hardware specialisations
    common-cpu-intel
    common-gpu-nvidia
    common-pc-laptop
    common-pc-ssd

    # Nix configuration common to all hosts
    ../common.nix

    # Nix configuration specific to this host
    ./configuration.nix
  ];

  # Custom module options
  config.appsmith = {
    # kernelPackages = pkgs.linuxPackages_latest;

    nix = {
      allowUnfree = true;
      stateVersion = "24.05";
    };

    dev = {
      enable = true;
      adb = true;
    };

    experiments.enable = true;

    host = {
      name = "gamora";
      rootHashedPassword = "$6$EKcuILVneuit/3cC$K4ZUK1E/e09.mdyGvM7T5GHapFnUE7PsEPc1nrTQUjn1WbeRE/h9CiRrluDv7UsUj.2bXm3kQcyHqJrQnp8v//";
      users = import ../../users;
    };

    # Enable games, so I can occasionally let my laptop do what it's designed for ;o)
    games.enable = true;

    gui = {
      enable = true;
      plasma6 = {
        enable = true;
        defaultSessionX11 = true;
      };
    };

    sound.enable = true;
  };
}
