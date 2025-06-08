{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (config.commands)
    hold'
    glow
    lynx
    decompress
    pistol
    open-with
    ide
    exo-open
    iso
    clone
    ;
in
{
  # desktop entries will show up in `share/applications/` of either:
  # - nixos system: /run/current-system/sw/
  # - nixos user: /etc/profiles/per-user/USER/
  # - home-manager: ~/.nix-profile/
  home.packages =
    let
      # redundant with mime associations / `programs.pistol` / `dmenu run`?
      commandDesktop =
        name: command: mimeTypes:
        (pkgs.makeDesktopItem {
          inherit name mimeTypes;
          desktopName = name;
          genericName = name;
          tryExec = command;
          # https://codeberg.org/kiara/cfg/issues/294
          # terminal = true;
          # exec = command;
          # exec = "${command} %f"; # Unable to spawn ... because it doesn't exist on the filesystem (ENOENT: No such file or directory)
          exec = hold' "${command} %f";
          icon = "utilities-terminal";
          categories = [
            "Office"
            "Viewer"
          ]; # https://askubuntu.com/a/674411/332744
        });
      genericDesktop =
        name: attrs:
        (pkgs.makeDesktopItem (
          {
            inherit name;
            desktopName = name;
            genericName = name;
          }
          // attrs
        ));
    in
    [
      (commandDesktop "exo-open" exo-open [ "application/x-desktop" ])

      (commandDesktop "iso" iso [ "application/vnd.efi.iso" ])

      (commandDesktop "glow" "${glow} -p" [ "text/markdown" ])

      (commandDesktop "lynx" lynx [
        "x-scheme-handler/https"
        "x-scheme-handler/http"
        "text/html"
      ])

      # https://code.google.com/archive/p/theunarchiver/wikis/SupportedFormats.wiki
      (commandDesktop "decompress" decompress [
        "application/x-zip"
        "application/x-gzip"
        "application/x-gzip-compressed"
        "application/gzip-compressed"
        "application/gzipped"
        "gzip/document"
        "application/gzip"
        "application/x-gunzip"
        "application/x-tar"
        "application/vnd.rar"
        "application/x-rar"
        "application/x-rar-compressed"
        "application/x-bzip2"
        "application/x-7z-compressed"
      ])

      (commandDesktop "ide" ide [
        "inode/directory"
        "inode/mount-point"
      ])

      (commandDesktop "clone" clone [ "x-scheme-handler/git" ])

      # fallback option delegating MIME handling to pistol
      (commandDesktop "pistol" pistol
        # grab associations from programs.pistol
        (lib.catAttrs "mime" config.programs.pistol.associations)
      )

      # fallback option allowing to pick an application to open the file with
      (commandDesktop "open-with" open-with (lib.attrNames config.xdg.mimeApps.defaultApplications))

      (genericDesktop "Shut down" {
        exec = "systemctl poweroff -i";
        icon = "system-shutdown";
      })

      (genericDesktop "Restart" {
        exec = "systemctl reboot";
        icon = "system-reboot";
      })

      (genericDesktop "Log out" {
        exec = "niri msg action quit";
        icon = "system-log-out";
      })

      (genericDesktop "Suspend" {
        exec = "systemctl suspend-then-hibernate";
        icon = "system-suspend";
      })

      (genericDesktop "Hibernate" {
        exec = "systemctl hibernate";
        icon = "system-hibernate";
      })

      (genericDesktop "Lock" {
        exec = "swaylock";
        icon = "system-lock-screen";
      })
    ];
}
