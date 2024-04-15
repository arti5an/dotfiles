{
  config,
  lib,
  pkgs,
  ...
}: {
  options.appsmith.gui.plasma6 = {
    enable = lib.mkEnableOption "KDE Plasma 6";
    defaultSessionX11 = lib.mkEnableOption "X11 session by default";
  };

  config = lib.mkIf (config.appsmith.gui.enable && config.appsmith.gui.plasma6.enable) {
    environment = {
      sessionVariables = {
        # NIXOS_OZONE_WL = "1";
        SSH_ASKPASS_REQUIRE = lib.mkDefault "prefer"; # Use KDEWallet even in a terminal
        VISUAL = lib.mkDefault "kate";
      };
      systemPackages = with pkgs; [
        kate
        kdePackages.kcmutils
      ];
    };

    services = {
      desktopManager.plasma6.enable = true;

      displayManager = {
        defaultSession = let
          session =
            if config.appsmith.gui.plasma6.defaultSessionX11
            then "plasmax11"
            else "plasma";
        in
          lib.mkOverride 990 session;
        sddm.enable = lib.mkDefault true;
      };
    };

    # make plasma usable when testing in a vm
    virtualisation.vmVariant.virtualisation = {
      memorySize = lib.mkDefault 2048;
      cores = lib.mkDefault 3;
    };
  };
}
