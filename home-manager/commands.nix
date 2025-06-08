{
  pkgs,
  lib,
  inputs,
  config,
  unstable,
  ...
}:
# TODO: JIT'ify? (#152)
let
  wrapSecrets =
    vars: pkg:
    (pkgs.writeShellScriptBin pkg.pname (
      lib.concatLines (
        (lib.mapAttrsToList (k: v: ''export ${k}="$(cat ${config.sops.secrets."${v}".path})"'') vars)
        ++ [ "${lib.getExe pkg} $@" ]
      )
    ));
  binaries =
    lib.listToAttrs (
      # manually specify mainProgram - alleviates #311 while i'm on unstable
      lib.attrsToList
        # pkgs: key = binary name = package name
        {
          inherit (pkgs)
            alacritty
            bat
            bluetuith
            cliphist
            curl
            ddcutil
            delta
            diffedit3
            diskonaut
            eza
            git
            glow
            gum
            jaq
            hexyl
            jujutsu
            just
            keepassxc
            lazyjj
            less
            libnotify
            light
            local-ai
            lynx
            nixd
            pamixer
            paperlike-go
            pavucontrol
            pistol
            playerctl
            powersupply
            ripdrag
            rmenu
            shfmt
            swaybg
            swayidle
            timg
            tor-browser
            tree
            visidata
            viu
            watchman
            wdisplays
            xdg-terminal-exec
            xwayland-satellite
            ;
          inherit (unstable) wallust;
          inherit (pkgs.xfce) thunar;
          inherit (pkgs.nodePackages)
            bash-language-server
            typescript
            typescript-language-server
            vscode-langservers-extracted
            ;
          swaync = pkgs.swaynotificationcenter;
          nixpkgs-review = wrapSecrets { GITHUB_TOKEN = "github-pat"; } unstable.nixpkgs-review;
          nextcloud-client = config.services.nextcloud-client.package;
        }
    )
    // lib.listToAttrs (
      lib.lists.map
        # key = binary name = package name
        lib.attrsFromPackage
        (lib.attrVals (lib.attrNames (import ../../packages.nix { inherit inputs lib pkgs; })) pkgs)
    )
    //
      # package name differs but binary name = key
      (
        (
          let
            inherit (config.programs) kitty helix;
          in
          lib.mapVals (lib.getAttr "package") {
            # programs.<name>.package
            kitten = kitty;
            hx = helix;
          }
        )
        // {
          btm = pkgs.bottom;
          bw = pkgs.bitwarden-cli;
          clangd = pkgs.clang-tools;
          dbus-update-activation-environment = pkgs.dbus;
          dust = pkgs.du-dust;
          exo-open = pkgs.xfce.exo;
          nix = config.nix.package;
          nixfmt = pkgs.nixfmt-rfc-style;
          nmtui = pkgs.networkmanager;
          nu = config.programs.nushell.package;
          pactl = pkgs.pulseaudio; # rmenu
          swaync-client = pkgs.swaynotificationcenter;
          systemctl = pkgs.systemd;
          wl-copy = pkgs.wl-clipboard;
          wl-paste = pkgs.wl-clipboard;
          wpctl = pkgs.wireplumber;
          xdg-open = pkgs.xdg-utils;
          xdg-terminal = pkgs.xdg-utils;
          zeditor = unstable.zed-editor; # git integration
        }
      );
  commands =
    lib.dryCommands (
      binaries
      // (lib.listToAttrs (
        lib.lists.map lib.attrsFromPackage
          # programs.<name>.package
          # N.B. do not list in home.packages to prevent clash with wrappers
          (
            lib.catAttrs "package" [
              config.programs.firefox
              config.programs.fzf
              config.programs.kitty
              config.programs.niri
              config.programs.swaylock
              config.programs.vscode
              config.programs.waybar
              config.programs.wezterm
              config.programs.yazi
              config.programs.zsh
            ]
          )
      ))
    )
    //
    # misc: either using args, or key != package name.
    # in case of args, consider a [wrapping overlay/script](https://wiki.nixos.org/wiki/Wrappers_vs._Dotfiles).
    {
      # terminal = "${wezterm}/bin/wezterm -e --always-new-process";
    };
in
{
  # refactor imports to options/config to factor out arg noise
  options.commands = lib.mkOption {
    type =
      let
        inherit (lib.types)
          either
          str
          functionTo
          attrsOf
          ;
      in
      attrsOf (either str (functionTo str));
    default = null;
    description = "binary reference to use throughout my config";
    example = {
      bash = "${pkgs.bash}/bin/bash";
    };
  };
  config.home.packages = lib.attrValues binaries;
  config.commands =
    commands
    // (
      let
        inherit (commands) nix xdg-terminal-exec zsh;
        shell = zsh;
      in
      {
        # command wrappers
        # "nmtui" -> "xdg-terminal-exec sh -c 'nmtui'"
        term = args: "${xdg-terminal-exec} sh -c '${lib.escape [ "'" ] args}'";
        term' = args: ''${xdg-terminal-exec} sh -c "${lib.escape [ "\"" ] args}"'';
        # "nmtui" -> "xdg-terminal-exec sh -c 'nmtui; $SHELL'"
        hold = args: "${xdg-terminal-exec} sh -c '${lib.escape [ "'" ] args}; ${shell}'";
        hold' = args: ''${xdg-terminal-exec} sh -c "${lib.escape [ "\"" ] args}; ${shell}"'';
        # "/bin/wofi" -> "(pidof wofi && kill -9 $(pidof wofi)) || wofi"
        toggle =
          program:
          "(pidof ${builtins.baseNameOf program} && kill -9 $(pidof ${builtins.baseNameOf program})) || ${program}";
      }
      # JIT: binary name != package name
      # "du-dust" -> "dust" -> "nix shell nixpkgs#du-dust --command dust"
      // (lib.mapAttrs (cmd: pkg: "${nix} shell nixpkgs#${pkg} --command \"${lib.escape [ "\"" ] cmd}\"")
        {
          # dust = "du-dust";
        }
      )
      # JIT: binary name = package name
      # "curl" -> "nix run nixpkgs#curl"
      // (lib.genAttrs [
        # "curl"
      ] (program: "${nix} run nixpkgs#${program}"))
    );
}
