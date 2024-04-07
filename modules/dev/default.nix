{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [./android.nix];

  options.appsmith.dev.enable = lib.mkEnableOption "dev environment";

  config = lib.mkIf config.appsmith.dev.enable {
    documentation.dev.enable = lib.mkDefault true;

    environment.systemPackages = with pkgs; [
      devbox
      git
    ];
  };
}
