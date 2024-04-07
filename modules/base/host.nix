{
  config,
  lib,
  ...
}: let
  hashedPasswordOpt = lib.mkOption {
    default = null;
    description = lib.mdDoc ''
      To generate a hashed password run `mkpasswd -m sha-512`.

      Set to blank for local-only password-less login.

      Set to null to prevent direct login.
    '';
    type = lib.types.nullOr lib.types.str;
  };
  userOpts = {
    name,
    config,
    ...
  }: {
    options = {
      name = lib.mkOption {
        description = lib.mdDoc ''
          The name of the user account. If undefined, the name of the
          attribute set will be used.
        '';
        type = lib.types.passwdEntry lib.types.str;
      };

      description = lib.mkOption {
        default = "";
        example = "Thomas Anderson";
        description = lib.mdDoc ''
          A short description of the user account, typically the
          user's full name.
        '';
        type = lib.types.passwdEntry lib.types.str;
      };

      uid = lib.mkOption {
        default = null;
        type = lib.types.nullOr lib.types.int;
      };

      isAdminUser = lib.mkEnableOption "administrative role for user";

      extraGroups = lib.mkOption {
        default = [];
        type = lib.types.listOf lib.types.str;
      };

      hashedPassword = hashedPasswordOpt;
    };

    config = lib.mkMerge [
      {name = lib.mkDefault name;}
    ];
  };
in {
  options.appsmith.host = {
    name = lib.mkOption {
      default = "nixos";
      example = "zion";
    };

    rootHashedPassword = hashedPasswordOpt;

    users = lib.mkOption {
      default = {};
      example = {
        neo = {
          uid = 1234;
          description = "Thomas Anderson";
          extraGroups = ["wheel"];
        };
      };
      description = lib.mdDoc ''
        User accounts you wish to have present on this system.
      '';
      type = lib.types.attrsOf (lib.types.submodule userOpts);
    };
  };

  config = {
    networking = {
      hostName = config.appsmith.host.name;
      networkmanager.enable = true;
    };

    users.mutableUsers = config.appsmith.host.rootHashedPassword == null;
    users.users =
      {
        root.hashedPassword = lib.mkOverride 990 config.appsmith.host.rootHashedPassword;
      }
      // lib.mapAttrs (
        _: value:
          lib.mkMerge [
            {isNormalUser = true;}
            {inherit (value) extraGroups;}
            (lib.mkIf value.isAdminUser {extraGroups = ["networkmanager" "wheel"];})
            (lib.filterAttrs (n: _: n != "extraGroups" && n != "isAdminUser") value)
          ]
      )
      config.appsmith.host.users;
  };
}
