{
  config,
  lib,
  pkgs,
  ...
}: {
  options.appsmith.dev.adb = lib.mkEnableOption "android debugger";

  config = lib.mkIf config.appsmith.dev.adb {
    programs.adb.enable = true;

    services.udev.packages = [
      pkgs.android-udev-rules
    ];
  };
}
