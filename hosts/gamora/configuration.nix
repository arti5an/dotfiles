{
  pkgs,
  inputs,
  ...
}: {
  imports = with inputs.nixos-hardware.nixosModules; [
    # Official hardware specialisations
    asus-battery
    common-cpu-intel
    common-gpu-nvidia
    common-pc-laptop
    common-pc-ssd

    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  boot = {
    binfmt.emulatedSystems = ["aarch64-linux"];

    # attempt to fix framerate issues under wayland, part 1 (requires proprietary driver)
    extraModprobeConfig = ''
      options nvidia NVreg_EnableGpuFirmware=0
    '';

    # pretend to be Windows so power management works properly
    kernelParams = ["acpi_osi=\"!\"" "acpi_osi=\"Windows 2015\""];
  };

  environment = {
    systemPackages = with pkgs; [
      vulkan-tools
    ];

    variables = {
      # attempt to fix framerate issues under wayland, part 2
      KWIN_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";
    };
  };

  hardware = {
    bluetooth.enable = true;

    nvidia = {
      modesetting.enable = true;
      open = false;

      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  services.fstrim.enable = true;

  time.timeZone = "Europe/London";

  virtualisation.docker.enable = true;
}
