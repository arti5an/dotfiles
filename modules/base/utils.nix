{
  config,
  pkgs,
  ...
}: {
  config.environment.systemPackages = with pkgs; [
    aha
    curl
    fd
    file
    fscrypt-experimental
    git
    killall
    ldns
    lm_sensors
    lsof
    neovim
    pciutils
    psmisc
    smartmontools
    sshfs
    tmux
    tree
    usbutils
    wget
  ];
}
