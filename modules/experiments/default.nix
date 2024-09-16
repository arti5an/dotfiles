{
  config,
  lib,
  pkgs-unstable,
  ...
}: {
  imports = [./calibre-web.nix];

  options.appsmith.experiments.enable = lib.mkEnableOption "experimental stuff";

  config = lib.mkIf config.appsmith.experiments.enable {
    environment = {
      sessionVariables = {
        EDITOR = lib.mkDefault "hx";
        VISUAL = lib.mkOverride 990 "zed";
      };

      systemPackages = with pkgs-unstable; [
        helix
        zed-editor
      ];
    };

    security.pam.enableFscrypt = true;
  };
}
