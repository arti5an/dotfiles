{
  inputs,
  ...
}: {
  imports = [
    # Nix community WSL module
    inputs.nixos-wsl.nixosModules.wsl
  ];

  # Revert a couple of my defaults
  boot.loader.systemd-boot.enable = false;
  services.smartd.enable = false;
  services.thermald.enable = false;

  virtualisation.docker.enable = true;

  wsl = {
    enable = true;
    wslConf.automount.options = "metadata,uid=1000,gid=100,fmask=033,dmask=022";
    defaultUser = "richard";
    interop.includePath = false;
    startMenuLaunchers = true;
  };
}
