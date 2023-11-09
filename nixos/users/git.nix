{ lib, ... }:

let
  email = "ruben.cano96@gmail.com";
  fullname = "rucadi";

in {
  programs = {
    git = {
      enable = true;

      lfs = {
        # Git Large File Storage (LFS)
        enable = true;
      };

      config = {
        commit = {
          # Remove the gpgsign line or set it to "false" to disable GPG signing...
          # gpgsign = "false";

          # Add this line to enable signing commits with your SSH key
          # You may also need to configure Git to use your SSH key globally
          # (outside of this NixOS configuration).
          # See the note below for instructions.
          signingKey = "ssh-ed25519";
        };

        #init = { defaultBranch = "main"; };
        #pull = { rebase = "true"; };
        core.editor = "kate";
        github.user = "rucadi";
        init.defaultBranch = "main";
        pull.rebase = true;



        user = {
          email = "${email}";
          name = "${fullname}";
        };

        status = { short = true; };
      };
    };
  };



}
