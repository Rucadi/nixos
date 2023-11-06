{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    (vscode-with-extensions.override {
      vscode = unstable.vscode;
      vscodeExtensions = [
        
        
        
       
        
        unstable.vscode-extensions.editorconfig.editorconfig
        unstable.vscode-extensions.esbenp.prettier-vscode
        unstable.vscode-extensions.github.copilot
        unstable.vscode-extensions.github.vscode-github-actions
        unstable.vscode-extensions.golang.go
        unstable.vscode-extensions.jnoortheen.nix-ide
        unstable.vscode-extensions.mads-hartmann.bash-ide-vscode
        unstable.vscode-extensions.mechatroner.rainbow-csv
        unstable.vscode-extensions.ms-azuretools.vscode-docker
        unstable.vscode-extensions.ms-vscode.cpptools
        vscode-extensions.ms-python.python
        vscode-extensions.ms-python.vscode-pylance
        unstable.vscode-extensions.ms-vscode.cmake-tools
        unstable.vscode-extensions.ms-vscode.cpptools
        unstable.vscode-extensions.ms-vsliveshare.vsliveshare
        unstable.vscode-extensions.redhat.vscode-yaml
        unstable.vscode-extensions.rust-lang.rust-analyzer
        unstable.vscode-extensions.ryu1kn.partial-diff
        unstable.vscode-extensions.serayuzgur.crates
        unstable.vscode-extensions.streetsidesoftware.code-spell-checker
        unstable.vscode-extensions.tamasfe.even-better-toml
        unstable.vscode-extensions.timonwong.shellcheck
        unstable.vscode-extensions.twxs.cmake
        unstable.vscode-extensions.vadimcn.vscode-lldb
        unstable.vscode-extensions.vscode-icons-team.vscode-icons
        unstable.vscode-extensions.yzhang.markdown-all-in-one
      ] ++ pkgs.unstable.vscode-utils.extensionsFromVscodeMarketplace [

        {
          name = "font-switcher";
          publisher = "evan-buss";
          version = "4.1.0";
          sha256 = "sha256-KkXUfA/W73kRfs1TpguXtZvBXFiSMXXzU9AYZGwpVsY=";
        }
        {
          name = "grammarly";
          publisher = "znck";
          version = "0.23.15";
          sha256 = "sha256-/LjLL8IQwQ0ghh5YoDWQxcPM33FCjPeg3cFb1Qa/cb0=";
        }
        { # 
          name = "linux-desktop-file";
          publisher = "nico-castell";
          version = "0.0.21";
          sha256 = "sha256-4qy+2Tg9g0/9D+MNvLSgWUE8sc5itsC/pJ9hcfxyVzQ=";
        }
        { #
          name = "nelua";
          publisher = "alexgb";
          version = "0.1.0";
          sha256 = "sha256-6r0l6p6rDBeCTPLqFRHD3/hQJxb8me08C0Zqti8Hr18=";
        }
        { #
          name = "non-breaking-space-highlighter";
          publisher = "viktorzetterstrom";
          version = "0.0.3";
          sha256 = "sha256-t+iRBVN/Cw/eeakRzATCsV8noC2Wb6rnbZj7tcZJ/ew=";
        }        

        {
          name = "vscode-front-matter";
          publisher = "eliostruyf";
          version = "9.3.1";
          sha256 = "sha256-75nnO+JbIXCkEQT8x+F41yn01lRLqsgl+eZ92kJxeZU=";
        }
        {
          name = "vscode-mdx";
          publisher = "unifiedjs";
          version = "1.4.0";
          sha256 = "sha256-qqqq0QKTR0ZCLdPltsnQh5eTqGOh9fV1OSOZMjj4xXg=";
        }

        { #
          name = "vscode-power-mode";
          publisher = "hoovercj";
          version = "3.0.2";
          sha256 = "sha256-ZE+Dlq0mwyzr4nWL9v+JG00Gllj2dYwL2r9jUPQ8umQ=";
        }
      ];
    })
  ];

  services.vscode-server.enable = true;
  # May require the service to be enable/started for the user
  # - systemctl --user enable auto-fix-vscode-server.service --now
}