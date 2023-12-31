# Common configuration for all users.
{ config, pkgs, ... }: {
  imports = [
    ./user.nix
    ./theme.nix
  ];

  nix.package = pkgs.nixFlakes;

  home = {
    username = config.user.name;
    homeDirectory = "/home/${config.user.name}";
    stateVersion = "23.05";
  };

  systemd.user.startServices = true;
  programs.home-manager.enable = true;
}
