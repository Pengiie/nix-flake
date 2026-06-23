{ inputs, pkgs, system, config, lib, ... }: let
  kicad-fixed = pkgs.writeShellScriptBin "kicad-fixed" ''
      GTK_THEME=Adwaita gdb -ex=r -ex=q --args bash -e /home/nathan/.nix-profile/bin/kicad
  '';
in {
  imports = [
  # Must be imported for every user.
  ./user.nix

  ./modules/zsh.nix
  ./modules/git.nix
  ./modules/dev.nix
  ./modules/direnv.nix
  ./modules/renderdoc.nix
  ./modules/kitty.nix
  ./modules/obs.nix
  ./modules/google-chrome.nix
  ./modules/theming.nix
  ./modules/discord.nix
  ./modules/virt.nix

  ./modules/nvim
  # ./modules/citra

  # Encapsulates the entire DE
  ./modules/desktop.nix
  ];

  user = {
    name = "nathan";
    email = "nathan@pengie.dev";

    shellAliases = {
      notes = "cd /home/nathan/notes";
      para = "cd /home/nathan/dev/paratym";
      rogue = "cd /home/nathan/dev/paratym/rogue";
      flake = "cd /home/nathan/flake";
      wuser = "cd /mnt/windows/Users/nathan";
      fadedrya = "kitty +kitten ssh nathan@192.168.0.250";
    };

    git = {
      username = "pengiie";
      email = "nathan@pengie.dev";
    };

    obs.droidcam = !config.host.laptop;

    desktop = {
      enableWallpaper = true;
    };
  };

  nixpkgs.overlays = [
    inputs.firefox-nightly.overlays.firefox
  ];

  home.packages = with pkgs; lib.lists.optionals (!config.host.laptop) [
    inputs.nixpkgs-unstable.legacyPackages.${system}.jetbrains.rust-rover
    inputs.nixpkgs-unstable.legacyPackages.${system}.jetbrains.clion
    vscode
    vscode-extensions.vadimcn.vscode-lldb
    osu-lazer-bin

    gh-markdown-preview

    gimp3
    blender
    musescore
    muse-sounds-manager
    audacity
    krita
    prismlauncher
    lumafly
    clonehero
    # todo: when school ends delete
    (zoom-us.override {
      hyprlandXdgDesktopPortalSupport = true;
    })

    image-roll
    wineWowPackages.waylandFull
    winetricks
    opentabletdriver
    openvpn

    kicad-fixed
    kicad
    librecad
    freecad
    easyeffects

    inputs.nixpkgs-25.legacyPackages.${system}.azahar

    qdirstat
    pkgs.kdePackages.kdenlive
    showmethekey
    waywall

    # Gnome keyring prompter for secrets
    pkgs.gcr

    jre

    # (mathematica.override {
    #   webdoc = true;
    # })

    alsa-scarlett-gui
    (inputs.nixpkgs-24.legacyPackages.${system}.bottles)
  ];

  home.file."wineasio-pkg".source = pkgs.wineasio;

  xdg.desktopEntries.kicad-fixed = {
    name = "Kicad Fixed";
    exec = "kicad-fixed";
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
       pkgs.xdg-desktop-portal-gtk
    ];
  };

  services.gnome-keyring.enable = true;

  wayland.windowManager.sway = {
    enable = true;
    config.startup = [
    {command = "kitty";}
    ];
  };
}
