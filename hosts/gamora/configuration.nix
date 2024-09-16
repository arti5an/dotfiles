{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  boot = {
    binfmt.emulatedSystems = ["aarch64-linux"];
    kernelParams = ["acpi_osi=\"!\"" "acpi_osi=\"Windows 2015\""];
  };

  hardware.bluetooth.enable = true;

  services.fstrim.enable = true;

  time.timeZone = "Europe/London";

  virtualisation.docker.enable = true;
}
