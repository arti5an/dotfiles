{
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

    dev = {
      enable = true;
      adb = true;
    };

    experiments = {
      enable = true;
      calibre-web.enable = false;
    };

    host = {
      name = "rogue";
      rootHashedPassword = "$6$EKcuILVneuit/3cC$K4ZUK1E/e09.mdyGvM7T5GHapFnUE7PsEPc1nrTQUjn1WbeRE/h9CiRrluDv7UsUj.2bXm3kQcyHqJrQnp8v//";
      users = {
        artisan = import ../../users/artisan.nix;
        richard = import ../../users/richard.nix;
      };
    };

    # Enable games, so I can occasionally let my laptop do what it's designed for ;o)
    games.enable = true;

    gui = {
      enable = true;
      sway.enable = true;
    };

    sound.enable = true;
  };
}
