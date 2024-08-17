{ pkgs, ... }: {
  imports = [
    ../common

    ./hardware.nix
    ./config.nix
    ./nvidia.nix
  ];

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false; 
  };

  programs.ssh.startAgent = true;

  users.users."nathan".openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFrpkAQpZDGEQ7wK0k/HqMs/5pUdR5ZTsRLRpEg1lBFp nathan"
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  programs.gamescope.enable = true;

  services.pipewire.jack.enable = true;
  services.pipewire.extraConfig.pipewire = {
    "default.clock.rate" = 48000;
  };
  # Persist the auto-mute = false for speaker in alsa mixer
  hardware.alsa.enablePersistence = true;
  programs.noisetorch.enable = true;

  networking.firewall.checkReversePath = "loose";
}
