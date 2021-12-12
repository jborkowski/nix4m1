{ config, lib, pkgs, ... }: {

  services.nix-daemon.enable = true;
  security.pam.enableSudoTouchIdAuth = true;

  environment.systemPackages = with pkgs; [
    cachix # nix caching
    alacritty
    jq # A lightweight and flexible command-line JSON processor
    fd # A simple, fast and user-friendly alternative to find
    direnv # A shell extension that manages your environment
    uutils-coreutils # Cross-platform Rust rewrite of the GNU coreutils
    xcp # An extended cp(1)
    lsd # The next gen ls command
    htop # An interactive process viewer for Linux
    sqlite # A self-contained, serverless, zero-configuration, transactional SQL database engine
    procs # A modern replacement for ps written in Rust
    tree # Command to produce a depth indented directory listing
    zoxide # A fast cd command that learns your habits
    discocss # A tiny Discord css-injector
    # nixops # NixOS cloud provisioning and deployment tool
    ripgrep # fast grep
    rnix-lsp # nix lsp server
    tldr # summary of a man page
    docker-compose # docker manager
    killall # kill processes by name
    neofetch # command-line system information
    nyancat # the famous rainbow cat!

    # Formatting
    nixfmt # An opinionated formatter for Nix
    black # The uncompromising Python code formatter
    shellcheck # Shell script analysis tool

    # Language Servers
    rnix-lsp # nix lsp server

    python39
    python39Packages.grip
  ];
}
