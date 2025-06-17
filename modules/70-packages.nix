{
  config,
  pkgs,
  rucadiPkgs,
  eden,
  ...
}:
# System packages & tmpfiles rules
{
  environment.systemPackages = with pkgs; [
    eden
    tkmm
    ukmm
    ryubing
    jhentai
    cemu
    ollama
    dolphin-emu
    aria2
    wget
    curl
    brave
    gparted
    vscode
    nixfmt-rfc-style
    mangohud
    protonup-qt
    lutris
    bottles
    heroic
    steamcmd
    stremio
    git
    virt-manager
    looking-glass-client
    quickemu
    xdg-utils
    kitty
    rucadiPkgs.whatsapp-electron
    pass
    blender
    krita
    vlc
    btop
    direnv
    telegram-desktop
    android-studio-full
    android-tools
    gcc
    gdb
    heaptrack
  ];

  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 rucadi qemu-libvirtd -"
  ];
}
