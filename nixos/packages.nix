{ pkgs }:

with pkgs;
let shared-packages = import ../shared/packages.nix { inherit pkgs; }; in
shared-packages ++ [

  # App and package management
  appimage-run
  home-manager

  # IDE
  vscode
  discord
  tdesktop

  # screen recorder
  obs-studio

  # Media and design tools
  vlc
  fontconfig
  font-manager

  # Audio tools
  pavucontrol # Pulse audio controls

  # Messaging and chat applications
  tdesktop # telegram desktop

  # Testing and development tools
  rnix-lsp # lsp-mode for nix
  qmk

  # Screenshot and recording tools
  flameshot
  simplescreenrecorder

  # Text and terminal utilities
  feh # Manage wallpapers
  screenkey
  tree
  unixtools.ifconfig
  unixtools.netstat
  xclip
  xorg.xwininfo # Provides a cursor to click and learn about windows

  # File and system utilities
  inotify-tools # inotifywait, inotifywatch - For file system events
  libnotify
  playerctl # Control media players from command line
  pinentry-curses
  pcmanfm # Our file browser
  xdg-utils

  # Other utilities
  xdotool
  brave

  # PDF viewer
  zathura


  
  helix
  git
  progress
  ripgrep
  procs

  aria
  sd
  ouch
  duf
  du-dust
  fd
  jq
  gh
  trash-cli
  zoxide
  tokei
  fzf
  bat
  mdcat
  pandoc
  lsd
  gping
  viu
  tre-command
  felix-fm
  chafa

  lazydocker
  lazygit
  neofetch
  onefetch
  ipfetch
  cpufetch
  starfetch
  octofetch
  htop
  bottom
  btop

  pipes-rs
  rsclock
  cava
  figlet

  numix-icon-theme-circle
  colloid-icon-theme
  catppuccin-gtk
  catppuccin-kvantum
  catppuccin-cursors.macchiatoTeal

  at-spi2-atk
  pamixer
  pavucontrol
  qt6.qtwayland
  psi-notify
  poweralertd

  gammastep

  playerctl
  psmisc
  imagemagick

  clipboard-jh
  xdg-utils
  wtype
  wlrctl

  nuspell
  hyphen
  hunspell
  hunspellDicts.en_US
  hunspellDicts.uk_UA
  hunspellDicts.ru_RU
  hunspellDicts.es_ES

  vulnix       #scan command: vulnix --system
  clamav       #scan command: sudo freshcalm; clamscan [options] [file/directory/-]
  
  nvtop
  usbutils
  dig
  speedtest-rs

]
