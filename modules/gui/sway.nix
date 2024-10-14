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
        greetd.tuigreet
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
      greetd = {
        enable = true;
        settings.default_session.command = "tuigreet --cmd sway --issue --time --remember --asterisks";
      };

      gnome.gnome-keyring.enable = true;
    };
  };
}
