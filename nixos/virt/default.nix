{ config, inputs, pkgs, dconf, ... }:

let user = "rucadi";
in
{


    # Add docker daemon
    virtualisation.docker.enable = true;
    virtualisation.docker.logDriver = "json-file";


    users.users.${user}.extraGroups = [ "libvirtd" ];

    systemd.user.services.scream-ivshmem = {
    enable = true;
    description = "Scream IVSHMEM";
    wantedBy = [ "multi-user.target" ];
    requires = [ "pulseaudio.service" ];
    };


    environment.systemPackages = with pkgs; [
        OVMFFull
        gnome.adwaita-icon-theme
        kvmtool
        libvirt
        qemu
        spice
        spice-gtk
        spice-protocol
        spice-vdagent
        swtpm
        virt-manager
        virt-viewer
        win-spice
        win-virtio
    ];

  # Manage the virtualisation services
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;
}
