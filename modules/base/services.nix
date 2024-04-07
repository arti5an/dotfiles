{
  config,
  lib,
  ...
}: {
  config = {
    # Use the ssh agent
    programs.ssh.startAgent = lib.mkDefault true;

    services = {
      # Enable avahi for service discovery
      avahi = lib.mkDefault {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };

      # Enable the firmware update daemon
      fwupd.enable = lib.mkDefault true;

      # Enable use of lvm2
      lvm.enable = lib.mkDefault true;

      # Enable the OpenSSH daemon
      openssh.enable = lib.mkDefault true;

      # Enable the smart monitoring daemon
      smartd.enable = lib.mkDefault true;

      # Enable the thermal monitoring daemon
      thermald.enable = lib.mkDefault true;

      # Enable CUPS to print documents, if there's a GUI.
      printing = lib.mkIf config.appsmith.gui.enable {
        enable = lib.mkDefault true;
        cups-pdf.enable = lib.mkDefault true;
      };
    };
  };
}
