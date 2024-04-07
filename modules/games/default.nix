{
  config,
  lib,
  pkgs,
  ...
}: {
  options.appsmith.games = {
    enable = lib.mkEnableOption "games";

    controllerModules = lib.mkOption {
      default = with config.appsmith.kernelPackages; [xone xpadneo];
      type = lib.types.listOf lib.types.package;
    };

    steam.enable = lib.mkOption {
      default = true;
      example = false;
      description = "Whether to enable Steam.";
      type = lib.types.bool;
    };
  };

  config = lib.mkIf config.appsmith.games.enable {
    assertions = [
      {
        assertion = config.appsmith.games.enable -> config.appsmith.gui.enable;
        message = "Cannot enable games without enabling GUI environment!";
      }
    ];

    boot.extraModulePackages = config.appsmith.games.controllerModules;

    environment.systemPackages = with pkgs;
      lib.mkIf config.appsmith.games.steam.enable [
        protontricks
        steam-run
      ];

    programs.steam.enable = config.appsmith.games.steam.enable;
  };
}
