{ nixpkgs, ... }: {
  nixpkgs.overlays = [
    ./chrome
  ];
}
