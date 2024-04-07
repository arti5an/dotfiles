{
  config,
  lib,
  pkgs,
  ...
}: {
  options.appsmith.experiments.enable = lib.mkEnableOption "experimental stuff";

  config = lib.mkIf config.appsmith.experiments.enable {
    environment = {
      sessionVariables = {
        EDITOR = lib.mkDefault "hx";
      };

      systemPackages = with pkgs; [
        helix
      ];
    };
  };
}
