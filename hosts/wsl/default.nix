{inputs, ...}: {
  imports = [
    # Nix configuration common to all hosts
    ../common.nix

    # Nix configuration specific to this host
    ./configuration.nix
  ];

  # Custom module options
  config.appsmith = {
    nix = {
      allowUnfree = true;
      stateVersion = "24.05";
    };

    dev.enable = true;

    host = {
      name = "wsl";
      rootHashedPassword = "$6$EKcuILVneuit/3cC$K4ZUK1E/e09.mdyGvM7T5GHapFnUE7PsEPc1nrTQUjn1WbeRE/h9CiRrluDv7UsUj.2bXm3kQcyHqJrQnp8v//";
      users.richard = import ../../users/richard.nix;
    };
  };
}
