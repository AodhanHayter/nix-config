# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{ inputs, lib, config, pkgs, ... }: {

  imports = [
    # If you want to use modules from other flakes (such as nixos-hardware), use something like:
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # It's strongly recommended you take a look at
    # https://github.com/nixos/nixos-hardware
    # and import modules relevant to your hardware.

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix

    # You can also split up your configuration and import pieces of it here.
  ];

  # Remove if you wish to disable unfree packages for your system
  nixpkgs.config.allowUnfree = true;

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
  };

  nix = {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.interfaces.enp4s0.wakeOnLan.enable = true;
  networking.extraHosts =
    ''
      127.0.0.1 lcl.kyruus.com
    '';

  # Set your time zone.
  time.timeZone = "America/Denver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # services.xserver.windowManager.xmonad.enable = true;

  # Enable the Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager = {
    plasma5 = {
      enable = true;
    };
  };

  services.xserver.videoDrivers = ["nvidia"];

  # Enable gnome keyring
  services.gnome.gnome-keyring.enable = true;

  # flatpak
  services.flatpak.enable = true;
  xdg.portal.enable = true;


  systemd.services.ssh-no-sleep = {
    enable = true;
    description = "Disable machine sleep when there is an active ssh session";
    before = ["sleep.target"];
    requiredBy = ["sleep.target"];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''
        ${pkgs.bash}/bin/bash -c "if [[ $(${pkgs.unixtools.netstat}/bin/netstat -tnpa | grep \"ESTABLISHED.*sshd\") ]]; then false; else true; fi"
      '';
    };
  };

  systemd.services.combine-ctrl-escape = {
    enable = true;
    description = "Combine Ctrl+Escape use the xcape program";
    documentation = ["man:xcape(1)" "https://github.com/alols/xcape"];
    after = ["graphical.target"];

    serviceConfig = {
      Type = "forking";
      ExecStart = ''${pkgs.xcape}/bin/xcape -e "Control_L=Escape"'';
      Restart = "always";
    };

    wantedBy = ["graphical.target"];
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
    xkbOptions = "ctrl:nocaps";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # bluetooth
  hardware.bluetooth.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # sudo settings
  security.sudo.extraConfig = ''
    Defaults:aodhan timestamp_timeout=30
  '';

  programs.ssh = {
    startAgent = true;
  };

  users.defaultUserShell = pkgs.zsh;

  users.users = {
    aodhan = {
      isNormalUser = true;
      description = "Aodhan Hayter";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      openssh = {
        authorizedKeys = {
          keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFnEsBv5zrOZzeQSymd/WKottg28l0mav/J0m0/Q3E4X aodhan.hayter@gmail.com"
          ];
        };
      };
    };
  };

  environment.pathsToLink = [ "/share/zsh" ];

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    firefox
    brave
    xcape
    zplug
    alacritty
    wine64
    gnupg
    pinentry-curses
    xclip
    nssTools
    gnome.gnome-tweaks
    home-manager
    cachix
    flyctl
  ];

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = ["FiraCode"]; })
  ];

  virtualisation.docker.enable = true;

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    # Forbid root login through SSH.
    permitRootLogin = "no";
    # Use keys only. Remove if you want to SSH using password (not recommended)
    passwordAuthentication = false;
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [80 443 3000 6006];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.05";
}
