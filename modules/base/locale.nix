{
  config,
  lib,
  ...
}: let
  locale = "en_GB.UTF-8";
in {
  config = {
    console.keyMap = lib.mkDefault "uk";

    i18n = {
      defaultLocale = lib.mkDefault locale;
      extraLocaleSettings = {
        LC_ADDRESS = locale;
        LC_IDENTIFICATION = locale;
        LC_MEASUREMENT = locale;
        LC_MONETARY = locale;
        LC_NAME = locale;
        LC_NUMERIC = locale;
        LC_PAPER = locale;
        LC_TELEPHONE = locale;
        LC_TIME = locale;
      };
    };
  };
}
