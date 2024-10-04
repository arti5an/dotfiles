{
  config,
  lib,
  pkgs,
  ...
}: {
  options.appsmith.gui.hyprland.enable = lib.mkEnableOption "Hyprland";

  config = lib.mkIf (config.appsmith.gui.enable && config.appsmith.gui.hyprland.enable) {
    environment.systemPackages = with pkgs; [
      kitty
      wl-clipboard
    ];

    programs.hyprland.enable = true;

    services = {
      displayManager = {
        defaultSession = lib.mkOverride 990 "hyprland";
        sddm.enable = lib.mkDefault true;
      };

      gnome.gnome-keyring.enable = true;
    };
  };
}
