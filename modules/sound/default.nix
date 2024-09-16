{
  config,
  lib,
  ...
}: {
  options.appsmith.sound.enable = lib.mkEnableOption "sound, using pipewire";

  config = lib.mkIf config.appsmith.sound.enable {
    sound.enable = lib.mkDefault true;
    hardware.pulseaudio.enable = lib.mkOverride 990 false;
    security.rtkit.enable = lib.mkDefault true;
    services.pipewire = {
      enable = lib.mkDefault true;
      alsa.enable = lib.mkDefault true;
      alsa.support32Bit = lib.mkDefault true;
      pulse.enable = lib.mkDefault true;
      jack.enable = lib.mkDefault true;
    };
  };
}
