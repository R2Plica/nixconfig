# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.grub.device = "/dev/nvme0n1"; # or "nodev" for efi only
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp4s0.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

  #For Steam To Work
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  hardware.pulseaudio.support32Bit = true;
  hardware.openrazer.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
  hardware.pulseaudio.extraConfig = ''
   load-module module-switch-on-connect
  '';
  hardware.bluetooth.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };
  fonts.fonts = with pkgs; [
    dejavu_fonts
    nerdfonts
    font-awesome-ttf
  ];


  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ace = {
    isNormalUser = true;
    shell = pkgs.fish;
    initialPassword = "1234";
    extraGroups = [ "wheel" "networkmanager" "docker" "plugdev"  ]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    coreutils
    file
    gnupg
    htop
    lsof
    unzip
    steam
    lutris
    zip
    wget
    vim
    zsh
    tmux
    git
    vulkan-tools
    wineWowPackages.stable
    openssh
    curl
    pass
    nvme-cli
    pstree
    #rpm
    fzf
    ag
    fasd
    mc
    unrar
    aspell
    aspellDicts.cs
    aspellDicts.en
    aspellDicts.es
    aspellDicts.fr
    pavucontrol
    mkpasswd
    kitty
    bash
    neovim
    emacs

    firefox-bin
    #tor-browser-bundle-bin
    xdg_utils
    networkmanagerapplet
    wirelesstools
    vlc
    #transmission
    #spotify
    playerctl
    evince
    blueman
    brave
    chromium
    chromedriver
    geckodriver
    vscode
    slack
    #discord
    #gitkraken
    cargo
    python3
    cmake
    gcc
    ninja
    meson

    #go
    nodejs
    #ansible
    #pywal
    tuir
    terraform
    azure-cli
    #awscli
    mysql-workbench

    # X11
    arandr
    feh
    #i3
    awesome
    #bspwm
    #i3lock
    libnotify
    polybar
    dunst
    rofi
    rofi-pass
    compton
    xautolock
    xorg.xbacklight
    xorg.setxkbmap
    xorg.xmodmap
    #xorg.xeva

    #xsel
    #arc-theme
    #scrot

    # let
    #   unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
    # in {
    #   environment.systemPackages = with pkgs; [
    #   terraform_-1_13
    #   	];
    #   }
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  boot.supportedFilesystems = [ "ntfs" ];
  services.openssh.enable = true;
  services.printing.enable = true;
  services.xserver.libinput.enable = true;
  services.xserver.libinput.tapping = true;
  services.xserver.libinput.scrollMethod = "twofinger";
  services.xserver.libinput.disableWhileTyping = true;
  services.xserver.libinput.naturalScrolling = true;
  services.mysql.enable = true;
  services.mysql.package = pkgs.mariadb;
  services.longview.mysqlPasswordFile = "/run/keys/mysql.password";
  # Enable the GNOME 3 Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome3.enable = true;
  # Enable the Plasma 5 Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.windowManager.awesome.enable = true;
  #services.xserver.windowManager.i3.enable = true;
  services.xserver.enable = true;
  #services.xserver.windowManager.bspwm.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  services.flatpak.enable = true;
  services.openvpn.servers = {
	pia = {
    		config = "config /home/ace/.config/pia/us_east.ovpn";
    		autoStart = false;
    		authUserPass.password = "*******" ;
    		authUserPass.username = "p000000" ;
    		updateResolvConf = true;
  	};
  };
  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}
