{
  config,
  lib,
  ...
}: {
  config = {
    console.keyMap = lib.mkDefault "uk";

    i18n.defaultLocale = lib.mkDefault "en_GB.UTF-8";
  };
}
