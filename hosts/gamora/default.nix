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
        defaultSessionX11 = false;
      };
    };

    sound.enable = true;
  };
}
