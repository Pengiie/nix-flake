{ pkgs, ... }: {
  imports = [
    ./direnv.nix
    ./git.nix
  ];

  home.packages = with pkgs; [
    ripgrep
    gnumake

    nodejs_20
    nodejs
    mysql-workbench

    cmake
    clang
    clangStdenv

    python3
    vscode
    yarn
  ];
}
