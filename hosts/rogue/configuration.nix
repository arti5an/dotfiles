{
  pkgs,
  inputs,
  ...
}: {
  imports = with inputs.nixos-hardware.nixosModules; [
    # Official hardware specialisations
    common-cpu-amd-pstate
    common-gpu-amd
    common-pc-ssd

    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  boot = {
    binfmt.emulatedSystems = ["aarch64-linux"];
    kernelPackages = pkgs.linuxPackages_latest;
  };

  hardware.bluetooth.enable = true;

  time.timeZone = "Europe/London";

  virtualisation.docker.enable = true;
}
