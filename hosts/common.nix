{
  # Homelab host names and public keys
  config.programs.ssh.knownHosts = {
    heimdall = {
      extraHostNames = ["heimdall.appsmith.uk" "192.168.1.10"];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH9ilmvPrGa0sq1NGOPIk4WKjnX9TrDt3sex0fsoKAI4";
    };
    jarvis = {
      extraHostNames = ["jarvis.appsmith.uk" "192.168.1.11"];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIyZBFDb882nGtiHbi6zBLSypcFmXbAAkfFrrG1E5FLH";
    };
    ultron = {
      extraHostNames = ["ultron.appsmith.uk" "192.168.1.12"];
      publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCf6NfjyechNTRiZ6ZJUCgiQn5VsVkzQF5X3qA7vpMhPsf/KNYsxTtfJ+IFJloptd3mj5GbbSkeusqhi8OjQkHFmQLHa0RCgs3NrSU2x0D8bTre5ptLFKLG8yCiZ0o0g622vHyWG5cm0wWGZaGSlZVHtxgvxfoqj5JJJblScGL48KEXVK6F9ivD+yekB4qFo8LTBZmIokSvP9BCpgq9zlAvk4cpHSrj/0dQfppzwNKyAGqcCytqmGKj5mO6K2v5ZUxoGXNdnyh5Y51i/PCU3Tcalmma2M82GWdXKl0ct/mcd0xVFMIQjziNznG5dBx/j9eDuEVZeGLt8phifgmtIM+j";
    };
  };
}
