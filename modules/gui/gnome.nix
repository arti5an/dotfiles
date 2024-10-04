{
  config,
  lib,
  ...
}: {
  options.appsmith.gui.gnome.enable = lib.mkEnableOption "Gnome";

  config = lib.mkIf (config.appsmith.gui.enable && config.appsmith.gui.gnome.enable) {
    services.xserver = {
      displayManager.gdm.enable = lib.mkDefault true;
      desktopManager.gnome.enable = true;
    };
  };
}
