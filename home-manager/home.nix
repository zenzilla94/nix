#          ╔══════════════════════════════════════════════════════════╗
#          ║                         home.nix                         ║
#          ╚══════════════════════════════════════════════════════════╝


# ══ TODO: ═════════════════════════════════════════════════════════════
#
# - [ ] Modularize packages into separate configuration files



# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs
, lib
, config
, pkgs
, nixpkgs-unstable
, zen-browser
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

      # Note-taking & Office
      obsidian # A powerful knowledge base that works on local Markdown files
      libreoffice-still # Comprehensive, professional-quality productivity suite, a variant of openoffice.org
      doing

      # Email Clients
      thunderbird # A free and open-source email, newsfeed, chat, and calendaring client

      # Web Browsers
      firefox # A free and open-source web browser

      # Version Control
      gh # GitHub’s official command line tool
      git # The fast distributed version control system
      lazygit # Simple terminal UI for git commands

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
      plocate # A locate command implementation
      zoxide # A smarter cd command
      bottom # A graphical process/system monitor for the terminal
      python3 # Python programming language
      neofetch # A command-line system information tool
      nnn # Terminal file manager
      thefuck # Correct your commands
      copyq
      curl
      planify
      gcc

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
      nixd
      cowsay # Configurable talking cow
      sl
      nyancat
      file # Determines file type
      which # Shows the full path of (shell) commands
      tree # Displays directories as trees (with optional color/HTML output)

      # Nix Related
      nix-output-monitor # Monitor for nix builds

      # Productivity
      hugo # Static site generator
      yazi
      file
      kitty

      nodejs
      nodejs_22
      lua # Lua programming language
      luarocks
      direnv # Environment switcher for the shell
      nix-direnv # direnv integration for nix
      inputs.zen-browser.packages."${system}".specific # Zen Browser

      nixpkgs-unstable.legacyPackages.${system}.neovim # Vim-fork focused on extensibility and usability

      starship # The minimal, blazing-fast, and infinitely customizable prompt for any shell

      rsync # A fast, versatile, remote (and local) file-copying tool
      duplicati # Free backup software to store encrypted backups online
      taskwarrior3 # Taskwarrior is Free and Open Source Software that manages your TODO list from the command line
      spotify

      darktable
      gimp
      go
      poetry

      cheat
      tldr
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
      userName = "mike";
      userEmail = "mikehall@mikehall94.com";
      extraConfig = {
        init.defaultBranch = "main";
        safe.directory = "home/mike/dotfiles";
      };
    };

    vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        github.copilot
      ];
    };


    direnv = {
      enable = true;
      nix-direnv.enable = true;
      # enableFishIntegration = true;
    };

    # Enable home-manager and neovim
    # neovim = {
    #     enable = true;
    #     package = nixpkgs-unstable.neovim;
    # };
    home-manager.enable = true;

    # fish.enable = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
