{
  config,
  lib,
  ...
}: {
  options.appsmith.experiments.calibre-web.enable = lib.mkEnableOption "calibre web experiment";

  config = lib.mkIf config.appsmith.experiments.calibre-web.enable {
    services.calibre-web = {
      enable = true;
      options = {
        calibreLibrary = "/srv/calibre";
        enableBookConversion = true;
        enableBookUploading = true;
      };
    };

    users.users.richard.extraGroups = ["calibre-web"];
  };
}
