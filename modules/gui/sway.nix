{
  config,
  lib,
  pkgs,
  ...
}: {
  options.appsmith.gui.sway = {
    enable = lib.mkEnableOption "Sway";
  };

  config = lib.mkIf (config.appsmith.gui.enable && config.appsmith.gui.sway.enable) {
    environment = {
      sessionVariables = {
        SSH_ASKPASS_REQUIRE = lib.mkDefault "prefer";
        VISUAL = lib.mkDefault "kate";
      };
      systemPackages = with pkgs; [
        grim
        mako
        slurp
        wl-clipboard
      ];
    };

    programs = {
      light.enable = true;

      sway = {
        enable = true;
        wrapperFeatures.gtk = true;
      };
    };

    services = {
      displayManager = {
        defaultSession = lib.mkOverride 990 "sway";
        sddm.enable = lib.mkDefault true;
      };

      gnome.gnome-keyring.enable = true;
    };

    systemd.user.services.kanshi = {
      description = "kanshi daemon";
      serviceConfig = {
        Type = "simple";
        ExecStart = ''${pkgs.kanshi}/bin/kanshi -c kanshi_config_file'';
      };
    };
  };
}
