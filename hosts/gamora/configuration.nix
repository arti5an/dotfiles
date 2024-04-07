{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

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

      # Build 245 driver as per NixOS 23.11
      package = let
        # https://forums.developer.nvidia.com/t/linux-6-7-3-545-29-06-550-40-07-error-modpost-gpl-incompatible-module-nvidia-ko-uses-gpl-only-symbol-rcu-read-lock/280908/19
        rcu_patch = pkgs.fetchpatch {
          url = "https://github.com/gentoo/gentoo/raw/c64caf53/x11-drivers/nvidia-drivers/files/nvidia-drivers-470.223.02-gpl-pfn_valid.patch";
          hash = "sha256-eZiQQp2S/asE7MfGvfe6dA/kdCvek9SYa/FFGp24dVg=";
        };
      in
        config.boot.kernelPackages.nvidiaPackages.mkDriver {
          version = "545.23.06";
          sha256_64bit = "sha256-QTnTKAGfcvKvKHik0BgAemV3PrRqRlM3B9jjZeupCC8=";
          sha256_aarch64 = "sha256-qkVP6AiXNoRTqgqPvs/AfErEq8BTQw25rtJ6GS06JTM=";
          openSha256 = "sha256-m7D5LZdhFCZYAIbhrgZ0pN2z19LsU3I3Q7qsKX7Z6mM=";
          settingsSha256 = "sha256-+X6gDeU8Qlvprb05aB2quM55y0zEcBXtb65e3Rq9gKg=";
          persistencedSha256 = "sha256-RQJAIwPqOUI5FB3uf0/Y4K/iwFfoLpU1/+BOK/KF5VA=";

          patches = [rcu_patch];
        };
    };
  };

  services.xserver.upscaleDefaultCursor = false;

  time.timeZone = "Europe/London";

  virtualisation.docker.enable = true;
}
