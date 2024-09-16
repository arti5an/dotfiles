{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [./gnome.nix ./plasma6.nix];

  options.appsmith.gui.enable = lib.mkEnableOption "graphical user interface";

  config = lib.mkIf config.appsmith.gui.enable {
    environment.systemPackages = with pkgs; [
      firefox
      glxinfo
      google-chrome
      (nerdfonts.override {
        fonts = ["FiraCode" "Hack" "Hasklig" "JetBrainsMono" "Meslo"];
      })
      orca
      thunderbird
      wezterm
    ];

    fonts.enableDefaultPackages = lib.mkDefault true;

    #hardware.opengl = {
    #  enable = lib.mkDefault true;
    #  driSupport = lib.mkDefault true;
    #  driSupport32Bit = lib.mkDefault true;
    #};

    # Fix GTK themes in Wayland applications
    programs.dconf.enable = lib.mkDefault true;

    services.xserver = {
      enable = lib.mkDefault true;

      # Configure keymap in X11
      xkb.layout = lib.mkDefault "gb";
    };
  };
}
