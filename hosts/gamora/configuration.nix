{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = with inputs.nixos-hardware.nixosModules; [
    # Official hardware specialisations
    common-cpu-intel
    common-gpu-nvidia
    common-pc-laptop
    common-pc-ssd

    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  boot = {
    binfmt.emulatedSystems = ["aarch64-linux"];
    kernelParams = ["acpi_osi=\"!\"" "acpi_osi=\"Windows 2015\""];
  };

  environment = {
    systemPackages = with pkgs; [
      vulkan-tools
    ];

    variables = {
      # WLR_NO_HARDWARE_CURSORS = "1";
      __GL_b5f2b3 = "0xFFFFFFFF"; # Fix graphical glitch affecting ED
    };
  };

  hardware = {
    bluetooth.enable = true;

    nvidia = {
      dynamicBoost.enable = true;
      modesetting.enable = true;
      nvidiaSettings = true;
      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
      powerManagement = {
        enable = true;
        finegrained = true;
      };

      # Build 555 driver as per NixOS 24.11
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "555.58.02";
        sha256_64bit = "sha256-xctt4TPRlOJ6r5S54h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
        sha256_aarch64 = "sha256-wb20isMrRg8PeQBU96lWJzBMkjfySAUaqt4EgZnhyF8=";
        openSha256 = "sha256-8hyRiGB+m2hL3c9MDA/Pon+Xl6E788MZ50WrrAGUVuY=";
        settingsSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
        persistencedSha256 = "sha256-a1D7ZZmcKFWfPjjH1REqPM5j/YLWKnbkP9qfRyIyxAw=";
      };
    };
  };

  services.xserver.upscaleDefaultCursor = false;

  time.timeZone = "Europe/London";

  virtualisation.docker.enable = true;
}
