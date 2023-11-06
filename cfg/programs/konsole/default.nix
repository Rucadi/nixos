{ config, lib, ... }:

#---------------------------------------------------------------------
# Aliases for Bash console (Konsole)
#---------------------------------------------------------------------

{
  programs = {
    # command-not-found.enable = false;

    # Add Konsole (bash) aliases
    bash = {
    
      # Add any custom bash shell or aliases here
      shellAliases = {

        #---------------------------------------------------------------------
        # Nixos related
        #---------------------------------------------------------------------
        
        # rbs2 =        "sudo nixos-rebuild switch -I nixos-config=$HOME/nixos/configuration.nix";
        garbage =     "sudo nix-collect-garbage --delete-older-than 7d";
        lgens =       "sudo nix-env --profile /nix/var/nix/profiles/system --list-generations";
        neu =         "sudo nix-env --upgrade";
        nopt =        "sudo nix-store --optimise";
        rbs =         "sudo nixos-rebuild switch";
        rebuild-all = "sudo nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot && sudo fstrim -av";
        switch =      "sudo nixos-rebuild switch -I nixos-config=$HOME/nixos/configuration.nix";
                
        #---------------------------------------------------------------------
        # Navigate files and directories
        #---------------------------------------------------------------------
        
        # cd = "cd ..";
        cl = "clear";
        copy = "rsync -P";
        la = "exa -a";
        ll = "exa -l";
        ls = "exa";
        lsla = "exa -la";

        #---------------------------------------------------------------------
        # File access
        #---------------------------------------------------------------------
        cp = "cp -riv";
        mkdir = "mkdir -vp";
        mv = "mv -iv";

        #---------------------------------------------------------------------
        # GitHub related
        #---------------------------------------------------------------------

        gitfix = "git fetch origin main && git diff --exit-code origin/main";

      };
    };
  };
}
