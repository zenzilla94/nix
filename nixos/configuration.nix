# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{ inputs
, lib
, config
, pkgs
, ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
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
    };
  };

  extraOptions = ''
      trusted-users = root mike
  '';


  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      extraOptions = ''
        trusted-users = root mike
      '';

      settings = {
        # Enable flakes and new 'nix' command
        experimental-features = "nix-command flakes";
        # Opinionated: disable global registry
        flake-registry = "";
        # Workaround for https://github.com/NixOS/nix/issues/9574
        nix-path = config.nix.nixPath;
      };
      # Opinionated: disable channels
      channel.enable = false;

      # Opinionated: make flake registry and nix path match flake inputs
      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

  # FIXME: Add the rest of your current configuration

  # Services
  services = {

    # Keyd
    keyd = {
      enable = true;

      # Swap capslock with ctrl + esc
      keyboards.default.settings = {
        main = {
          capslock = "overload(control, esc)";
          esc = "capslock";
        };
      };
    };

    # Tailscale
    tailscale.enable = true;

    # Printing
    printing = {
      enable = true;
      drivers = [ pkgs.brlaser ];
    };

    # Avahi
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };


    # Pipewire
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };

    # Xserver
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;

      xkb = {
        layout = "us";
        variant = "";
      };
    };

    # desktopManager.cosmic.enable = false;
    # displayManager.cosmic-greeter.enable = false;
  };

  # Set your hostname
  networking = {
    hostName = "zenbook";
    networkmanager.enable = true;
  };

  # Configure your system-wide user settings (groups, etc), add more users as needed.
  users = {
    users = {
      mike = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ];
      };
    };

    # This group is needed to use plocate
    groups = {
      plocate = { };
    };
  };

  # Pulseaudio
  hardware.pulseaudio.enable = false;

  # Boot
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  # Stupid error on rebuild
  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;
  # Time
  time.timeZone = "America/Edmonton";

  # systemPackages
  environment.systemPackages = with pkgs; [
    vim
    nerdfonts
    home-manager
    clipmenu
    htop
    git
    netcat-gnu
    wl-clipboard # Needed for neovim clipboard
    gnome-extension-manager
    gnome.gnome-shell-extensions
  ];

  # Fonts
  fonts.packages = with pkgs; [
    nerdfonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];

  # Hardware
  hardware.bluetooth.enable = true;


  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
  # TODO: Set your hostname
}
