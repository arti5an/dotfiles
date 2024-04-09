{
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  boot = {
    kernelParams = ["kunit.enable=0"];
    loader.systemd-boot.enable = false;
  };

  environment.systemPackages = with pkgs; [
    libraspberrypi
    raspberrypi-eeprom
  ];

  hardware = {
    enableRedistributableFirmware = true;
    deviceTree = {
      enable = true;
      filter = lib.mkForce "bcm2711-rpi-4-*.dtb";
    };
    raspberry-pi."4" = {
      apply-overlays-dtmerge.enable = true;
      fkms-3d.enable = true;
    };
  };

  services = {
    hardware.argonone.enable = true;
    thermald.enable = false;
  };

  virtualisation.docker.enable = true;
}
