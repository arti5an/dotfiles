{lib, ...}: {
  imports = [./host.nix ./locale.nix ./services.nix ./utils.nix];

  config = {
    boot = {
      # Use systemd boot
      loader = {
        systemd-boot.enable = lib.mkDefault true;
        efi.canTouchEfiVariables = lib.mkDefault true;
      };

      # Enable SysRq keys, e.g. Alt+SysRq+R,E,I,S,U,B to recover hung system.
      kernel.sysctl."kernel.sysrq" = lib.mkDefault 1;

      # Ensure tmp is clean on boot
      tmp.cleanOnBoot = lib.mkDefault true;
    };

    # Ensure openly available hardware patches are applied
    hardware.enableRedistributableFirmware = lib.mkDefault true;

    # Save power by default
    powerManagement.cpuFreqGovernor = lib.mkOverride 990 "powersave";
  };
}
