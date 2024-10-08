{ pkgs, ... }: {
  imports = [
    ../common

    ./hardware.nix
    ./config.nix
  ];

  environment.systemPackages = with pkgs; [
    acpi
  ];

  # "light" cli tool to control laptop screen brightness
  programs.light.enable = true;

  # Service to control fans through software
  services.thermald.enable = true;
  services.thermald.configFile = ./thermald-conf.xml;
  services.acpid.enable = true;

  programs.nix-ld.enable = true;
}
