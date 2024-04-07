{
  config,
  lib,
  ...
}: {
  # NOTE: This file is not referenced - I haven't started home manager integration yet
  config = {
    home-manager = {
      useGlobalPkgs = true;
      users =
        lib.genAttrs ["artisan" "richard"] (name: _: {
          home.stateVersion = config.appsmith.nix.stateVersion;
          systemd.user.sessionVariables = config.home-manager.users.${name}.home.sessionVariables;
        })
        // {
          root = _: {home.stateVersion = config.appsmith.nix.stateVersion;};
        };
    };
  };
}
