# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs
, lib
, config
, pkgs
, ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # TODO: Set your username
  home = {
    username = "mike";
    homeDirectory = "/home/mike";

    packages = with pkgs; [

      # Terminal Emulators
      alacritty # A fast, lightweight terminal emulator

      # Note-taking
      obsidian # A powerful knowledge base that works on local Markdown files

      # Email Clients
      thunderbird # A free and open-source email, newsfeed, chat, and calendaring client

      # Web Browsers
      firefox # A free and open-source web browser

      # Version Control
      gh # GitHub’s official command line tool

      # Terminal Multiplexers
      tmux # Terminal multiplexer

      # Media
      plexamp # A music player for Plex Pass users

      # Formatting Tools
      alejandra # A code formatter for Nix

      # Shells
      fish # Friendly interactive shell

      # Command History
      atuin # Replaces your existing shell history

      # Utilities
      bat # A cat clone with syntax highlighting
      ncdu # Disk usage analyzer with an ncurses interface
      zed-editor # A high-performance code editor
      plocate # A locate command implementation
      zoxide # A smarter cd command
      bottom # A graphical process/system monitor for the terminal
      python3 # Python programming language
      neofetch # A command-line system information tool
      nnn # Terminal file manager

      # Archives
      zip # Package and compress (archive) files
      xz # Lossless data compression
      unzip # Decompression program for .zip files
      p7zip # Command-line version of 7-Zip

      # Search Utilities
      ripgrep # Recursively searches directories for a regex pattern
      eza # A modern replacement for ‘ls’
      fzf # A command-line fuzzy finder

      # Networking Tools
      nmap # A utility for network discovery and security auditing

      # Miscellaneous
      cowsay # Configurable talking cow
      file # Determines file type
      which # Shows the full path of (shell) commands
      tree # Displays directories as trees (with optional color/HTML output)

      # Nix Related
      nix-output-monitor # Monitor for nix builds

      # Productivity
      hugo # Static site generator
    ];
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Programs
  programs = {
    # Basic configuration of git
    git = {
      enable = true;
      userName = "mike hall";
      userEmail = "mikehall@mikehall94.com";
    };

    # Enable home-manager and neovim
    home-manager.enable = true;
    neovim.enable = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
