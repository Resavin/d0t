# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, ... }:

let
  nixos-conf-editor = (import (pkgs.fetchFromGitHub {
    owner = "vlinkz";
    repo = "nixos-conf-editor";
    rev = "0.0.6";
    sha256 = "sha256-wJMUY4OCntFfR1BkTsia5tdNmaF5MBB3/n208Q/MPGA=";
  })) { };
  # firefox = import
  #   (builtins.fetchTarball {
  #     url = "https://github.com/NixOS/nixpkgs/archive/2407f8825b321617a38b86a4d9be11fd76d513da.tar.gz";
  #     sha256 = "0z7jz6j9v6j9z6v6j9z6v6j9z6v6j9z6v6j9z6v6j9z6v6j9z6v6";
  #   })
  #   { config = config.system.build; };
in

{
  # Three ways to override (let, packageOverrides and Overlays)
  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [
        libgdiplus
      ];
    };
    vim = pkgs.vim.overrideAttrs (_: {
      src = pkgs.fetchFromGitHub {
        owner = "vim";
        repo = "vim";
        rev = "652dee448618589de5528a9e9a36995803f5557a";
        sha256 = "sha256-BPsMqivBVfBJ6t5jWVaqFVmm1advTGqHMXG3dotEKBg=";
      };
    });
  };
  nixpkgs.overlays = [
    (self: super:
      {
        urAwesome = super.awesome.overrideAttrs (old: rec
        {
          pname = "urAwesome";
          version = "git-20220614-3a54221";
          src = super.fetchFromGitHub {
            owner = "awesomeWM";
            repo = "awesome";
            rev = "3a542219f3bf129546ae79eb20e384ea28fa9798";
            sha256 = "4z3w6iuv+Gw2xRvhv2AX4suO6dl82woJn0p1nkEx3uM=";
          };
          patches = [ ];
        });
      })
    # (self: super:
    #   {
    #     firefox78 = super.firefox.overrideAttrs (oldAttrs: {
    #       src = super.fetchFromGitHub {
    #         owner = "mozilla";
    #         repo = "gecko-dev";
    #         rev = "b853ca157ccd4d24f02b813c5ebb051972773d93";
    #         sha256 = "gtLaC0uNOHBwJWYWDLrbpG2p2mlJAh3r6mclAJ1Qe5Y=";
    #       };
    #     });
    #
    #   })
  ];
  ##nixpkgs.overlays#=#with#builtins;#[

  ######(self:#super:#{#awesome#=#super.awesome.override#{#gtk3Support#=#true;#};#})

  ######(
  ########import#(fetchGit#{
  ##########allRefs#=#true;
  ##########url#=#"https://github.com/stefano-m/nix-stefano-m-nix-overlays.git";
  ##########rev#=#"0c0342bfb795c7fa70e2b760fb576a5f6f26dfff";####git#revision#heere
  ############rev#=#"0000000000000000000000000000000000000000";####git#revision#heere
  ########})
  ######)
  ####(import#(builtins.fetchTarball#https://github.com/nix-community/emacs-overlay/archive/master.tar.gz))
  ####(builtins.getFlake#"github:fortuneteller2k/nixpkgs-f2k").overlays.default


  ##];
  # services.xserver.windowManager = {
  #   awesome = {
  #     enable = true;
  #     luaModules = lib.attrValues {
  #       inherit (pkgs.luaPackages) lgi ldbus luadbi-mysql luaposix;
  #     };
  #  luaModules = with pkgs.extraLuaPackages; [ # need overalys for this to work!
  #    connman_dbus
  #    connman_widget
  #    dbus_proxy
  #    enum
  #    media_player
  #    power_widget
  #    pulseaudio_dbus
  #    pulseaudio_widget
  #    upower_dbus
  #  ];
  #   };
  # };
  networking.firewall = {
    # if packets are still dropped, they will show up in dmesg
    logReversePathDrops = true;
    # wireguard trips rpfilter up
    extraCommands = ''
      ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 80 -j RETURN
      ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 80 -j RETURN
    '';
    extraStopCommands = ''
      ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 80 -j RETURN || true
      ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 80 -j RETURN || true
    '';
  };
  imports =
    [
      # (fetchTarball "https://github.com/msteen/nixos-vscode-server/tarball/master")
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #    (builtins.getFlake "github:fortuneteller2k/nixpkgs-f2k").nixosModules.stevenblack

      #<home-manager/nixos>
      # ./home-woman.nix
    ];

  systemd.watchdog.device = "/dev/watchdog";
  services.das_watchdog.enable = true;
  # systemd.services.ly.enable = true; # doesn't work
  # Bootloader.
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi = {
        efiSysMountPoint = "/boot/efi/";
        canTouchEfiVariables = true;
      };
      timeout = 5;
      grub = {
        enable = true;
        devices =["nodev"];
        efiSupport = true;
        enableCryptodisk = true;
        useOSProber = true;
        # extraConfig = ''
        #   GRUB_TIMEOUT=0
        #
        #   '';
      };
      # systemd-boot.enable = true;
    };
  };
  boot.loader.grub.theme =
    pkgs.fetchFromGitHub {
      owner = "Lxtharia";
      repo = "minegrub-theme";
      rev = "1e31c7feb22eadbe4f80f6f8c2d63681b337676f";
      sha256 = "sha256-zP+6xqlupDzYPe+24348uAjnD7nxggmC+tfUJkyf+hk=";
  };
  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  # networking.networkmanager.unmanaged = [
  # "*" "except:type:wwan" "except:type:gsm"
  # ];
  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.utf8";
    LC_IDENTIFICATION = "ru_RU.utf8";
    LC_MEASUREMENT = "ru_RU.utf8";
    LC_MONETARY = "ru_RU.utf8";
    LC_NAME = "ru_RU.utf8";
    LC_NUMERIC = "ru_RU.utf8";
    LC_PAPER = "ru_RU.utf8";
    LC_TELEPHONE = "ru_RU.utf8";
    LC_TIME = "ru_RU.utf8";
  };
              nixpkgs.config.permittedInsecurePackages = [
                "qtwebkit-5.212.0-alpha4"
              ];
  # AMd proprietera
  # services.xserver.videoDrivers = [ "amdgpu-pro" ];
# don't work
#   xdg.mime.defaultApplications = {
#   # "text/html" = "org.qutebrowser.qutebrowser.desktop";
#   "text/html" = "microsoft-edge.desktop";
#   "x-scheme-handler/http" = "org.qutebrowser.qutebrowser.desktop";
#   "x-scheme-handler/https" = "org.qutebrowser.qutebrowser.desktop";
#   "x-scheme-handler/about" = "org.qutebrowser.qutebrowser.desktop";
#   "x-scheme-handler/unknown" = "org.qutebrowser.qutebrowser.desktop";
# };
# Steam
  hardware.opengl.driSupport32Bit = true;
  environment.variables = lib.mkForce {
    QT_STYLE_OVERRIDE = "dracula-theme";
    EDITOR = "nvim";
  };

#   hardware.pulseaudio.configFile = pkgs.runCommand "default.pa" {} ''
#   sed 's/module-udev-detect$/module-udev-detect tsched=0/' \
#     ${pkgs.pulseaudio}/etc/pulse/default.pa > $out
# '';
#
  environment.etc."pulse/daemon.conf".text = lib.mkForce ''
    flat-volumes=no
    resample-method=speex-float-5
  '';

  # sudoedit
  # environment.variables.EDITOR = "nvim";
  # environment.variables.VISUAL = "subl";
  # environment.variables.SUDO_EDITOR = "subl";
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  # services.emacs.enable = true;
  # services.vscode-server.enable = true;




  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = (with pkgs; [
    # gnome-photos
    # gnome-tour
  ]) ++ (with pkgs.gnome; [
    # cheese # webcam tool
    # gnome-music
    gnome-terminal
    gedit # text editor
    epiphany # web browser
    geary # email reader
    # evince # document viewer
    # gnome-characters
    # totem # video player
    # tali # poker game
    # iagno # go game
    # hitori # sudoku game
    # atomix # puzzle game
  ]);

  # dconf.settings = {
  #   "/org/gnome/desktop/input-sources" = {
  #       xkboptions = "['grp:alt_shift_toggle']";
  #     } ;
  # };

  # services.xserver.displayManager.defaultSession = "none+awesome";
  # Configure keymap in X11
  services.xserver = {
    # displayManager.ly = {
    #   enable = true;
    #   defaultUser = "byakuya";
    # };
    displayManager.startx.enable = true;
    layout = "us,ru";
    xkbVariant = "";
    xkbOptions = "grp:alt_shift_toggle";
  };
  services.xserver.displayManager.sessionCommands =
    "${pkgs.xorg.xset}/bin/xset r rate 200 15";


services.greetd = {
  enable = true;
  settings = rec {
    # change to initial_session for autostart
    default_session = {
      # command = "${pkgs.urAwesome}/bin/awesome";
      command = "startx";
      user = "byakuya";
    };
    # default_session = initial_session;
  };
};


  services.xserver.libinput.touchpad.tapping = true;
  qt.enable = true;
  qt.platformTheme = "gtk2";
  qt.style = "gtk2";
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  security.rtkit.enable = true;
  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   pulse.enable = true;
  #   # If you want to use JACK applications, uncomment this
  #   #jack.enable = true;

  #   # use the example session manager (no others are packaged yet so this is enabled by default,
  #   # no need to redefine it in your config for now)
  #   #media-session.enable = true;
  # };

  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };

  # programs.vscode.package = pkgs.vscode.fhsWithPackages (ps: with ps; [ gcc gdb zlib openssl.dev pkg-config ]);
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.sway.enable = true;
  programs.waybar.enable = true;
services.lorri.enable = true; 
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Iosevka" "RobotoMono" "Mononoki" ]; })
    # noto-fonts
    corefonts
  ];
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    home-manager
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    cmake
    python310Packages.pip
    poetry
    libsForQt5.qt5ct
    qt5.full
    #python310 or python3 don't work its pip has some installed libs
    gnomeExtensions.material-shell
    gcc
    ntfs3g
    obsidian
    tdesktop
    gnome.gnome-tweaks
    feh
    discord
    gnomeExtensions.easyScreenCast
    htop
    llama
    zathura
    automake
    nix-prefetch-git
    xorg.xinit
    pkg-config
    zlib
    # lua
    # luaPackages.lua-lsp
    # luaPackages.luarocks # is the package manager for Lua modules
    # luaPackages.luadbi-mysql # Database abstraction layer
    # luaPackages.luafilesystem
    # luaPackages.lgi
    # inputs.hyprland.packages.x86_64-linux.hyprland


    (
      let
        my-python-packages = python-packages: with python-packages; [
          numpy
          pyqt5
          qt5
          matplotlib
          debugpy
          keyboard
          flask
          markupsafe
          notify2
          #liblo pyliblo pyxdg dumal oni dlya qt5 no ne nuzhni
          #other python packages you want
        ];
        python-with-my-packages = python3.withPackages my-python-packages;
      in
      python-with-my-packages
    )


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
  services.openssh.enable = true;

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
  system.stateVersion = "22.05"; # Did you read the comment?


  security.sudo.wheelNeedsPassword = false;
  ## Wireguard
  networking.firewall = {
    allowedUDPPorts = [ 51820 ]; # Clients and peers can use the same port, see listenport
  };
  # Enable WireGuard
  # networking.wg-quick.interfaces = {
  #   # "wg0" is the network interface name. You can name the interface arbitrarily.
  #   wg0 = {
  #     # Determines the IP address and subnet of the client's end of the tunnel interface.
  #     address = [ "10.123.0.6/32" ];
  #     listenPort = 51280; # to match firewall allowedUDPPorts (without this wg uses random port numbers)
  #
  #     # Path to the private key file.
  #     #
  #     # Note: The private key can also be included inline via the privateKey option,
  #     # but this makes the private key world-readable; thus, using privateKeyFile is
  #     # recommended.
  #     # privateKeyFile = "home/byakuya/wg.conf";
  #     privateKey = "4OiqEHlrQvYRhn8FnNgZAn3a4ePnWKacZ5mj6E7GPXI=";
  #     dns = [ "10.123.0.1" ];
  #
  #     peers = [
  #       # For a client configuration, one peer entry for the server will suffice.
  #
  #       {
  #         # Public key of the server (not a file path).
  #         publicKey = "ux1q8/TNi9mrvbxmENCvfCVRI5Zp7sGxg4CmlCgqxys=";
  #         # Forward all the traffic via VPN.
  #         allowedIPs = [ "0.0.0.0/0" ];
  #         # Or forward only particular subnets
  #         #allowedIPs = [ "10.100.0.1" "91.108.12.0/22" ];
  #
  #         # Set this to the server IP and port.
  #         endpoint = "34.116.247.205:51820"; # ToDo: route to endpoint not automatically configured https://wiki.archlinux.org/index.php/WireGuard#Loop_routing https://discourse.nixos.org/t/solved-minimal-firewall-setup-for-wireguard-client/7577
  #
  #         # Send keepalives every 25 seconds. Important to keep NAT tables alive.
  #         persistentKeepalive = 25;
  #       }
  #     ];
  #   };
  # };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  programs.fish.enable = true;
  services.flatpak.enable = true;
  services.postgresql.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.byakuya = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = "Byakuya";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" "wireshark" "postgres"];
    packages = with pkgs; [
      microsoft-edge
      fish
      yandex-disk
      starship
      mcfly
      bunnyfetch
      # dosbox-staging
      steam
      sublime4
      exa
      bat
      wireguard-tools
      libreoffice-qt
      gnome.dconf-editor
      neovim
      lm_sensors
      alacritty
      cargo
      unar
      unzip
      nixos-conf-editor
      gnumake
      # gnomeExtensions.lunar-calendar     needs smth
      clang-tools
      sumneko-lua-language-server
      nodePackages.pyright
      rnix-lsp
      btop
      virt-manager
      vscode.fhs
      waybar
      wofi
      # emacsGcc
      cachix
      hyprpaper # wallpaper for hyper
      gzdoom
      qbittorrent
      eww-wayland
      urAwesome # BOOOOOOOOm

      rofi
      acpi
      brightnessctl
      inotify-tools
      pamixer
      picom
      ly

      dmg2img #mac vm
      tldr
      nodejs
      vscode-extensions.sumneko.lua
      vscode-extensions.vscodevim.vim

      freeglut
      mesa
      libGLU
      glew
      gdb
      flameshot
      global

      nginx
      tracker
      imagemagick
      xorg.xkill
      file
      xclip

      wireshark
      distrobox
      lf
      zoxide
      cargo
      pulsemixer
      php
      pdftk
      wineWowPackages.stable
      redshift
      lxappearance
      du-dust
      firefox
      # firefox-bin
      stylua # for vim lsp
      lua
      # nodePackages.live-server
      barrier
      # nodePackages.typescript-language-server
      steam-run
      sqlite
      sqliteman
      fzf
      ripgrep
      ccls
      shfmt
      fuse
      appimage-run
      osu-lazer
      tree-sitter
      killall
      gh
      vimPlugins.nvim-treesitter
      pgadmin4
      ncurses
      direnv
      dbeaver
      manim
      python310Packages.manimpango
      vlc
      meld
      zstd
      i3-gaps
      php81Packages.composer
      tmux
      jetbrains.datagrip
      p7zip
      # zip
      jetbrains.pycharm-community
      rclone
      simplescreenrecorder
      libnotify
      dunst
    ];
  };
}

