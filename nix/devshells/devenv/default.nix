{
  inputs,
  pkgs,
  pkgsUnstable,
  ...
}: let
  unstablePkgs = with pkgsUnstable; [
    hugo
  ];
in
  inputs.devenv.lib.mkShell {
    inherit inputs;
    inherit pkgs;

    modules = [
      {
        # https://devenv.sh/reference/options/

        packages = with pkgs;
          [
            figlet
            hello

            nixpkgs-fmt
            statix

            sops
            #sops-init-gpg-key
            #sops-import-keys-hook
            ssh-to-age
            ssh-to-pgp
            age

            bashInteractive
            bash-completion

            gnutar

            # Other
            go
            golangci-lint
            golangci-lint-langserver
            gosec
            nodejs
            hugo
          ]
          ++ unstablePkgs;

        env = {
          DEVENV_DEVSHELL_ROOT = builtins.toString ./.;
        };

        enterShell = ''
          # Linters
          export HUNSPELL_CONFIG=''${PROJECT_DIR}/.linters/config/hunspell.conf
          export PRETTIER_CONFIG=''${PROJECT_DIR}/.linters/config/.prettierrc.yaml
          export YAMLLINT_CONFIG_FILE=''${PROJECT_DIR}/.linters/config/.yamllint.yml

          figlet ''${PROJECT_NAME:-Unknown}

          hello \
            --greeting \
            "
            Welcome ''${USER}!

            Project: ''${PROJECT_NAME:-Unknown}
            Shell: ''${PROJECT_SHELL:-Unknown}
            Directory: ''${PROJECT_DIR:-Unknown}
            "
        '';

        pre-commit = {
          default_stages = ["commit"];

          excludes = ["README.md"];

          hooks = {
            # Nix
            alejandra.enable = true;
            nixfmt.enable = false;
            nixpkgs-fmt.enable = false;
            deadnix.enable = true;
            statix.enable = true;

            # GitHub Actions
            actionlint.enable = true;

            # Bash
            bats.enable = true;
            shellcheck.enable = true;
            shfmt.enable = true;

            # Golang
            gofmt.enable = true;
            gotest.enable = true;
            govet.enable = true;
            revive.enable = true;

            # Spelling
            hunspell.enable = false;
            typos.enable = true;

            # Git commit messages
            commitizen.enable = true;

            # Markdown
            markdownlint = {
              enable = true;
            };
            mdsh.enable = true;

            # Common
            prettier.enable = true;

            # YAML
            yamllint.enable = true;
          };

          settings = {
            deadnix = {
              edit = false;
              noUnderscore = true;
              noLambdaPatternNames = true;
              noLambdaArg = true;
            };

            markdownlint = {
              config = {
                # No hard tabs allowed.
                no-hard-tabs = true;

                # First line headings
                MD041 = false;

                # Empty URLs
                MD042 = false;

                # Unordered list intendation.
                MD007 = {
                  indent = 2;
                };

                # Training spaces
                MD009 = {
                  br_spaces = 2;
                };

                # Line length
                MD013 = false;

                # Inline HTML
                MD033 = false;

                # List marker spaces.
                # Disabled for use with prettier.
                MD030 = false;
              };
            };

            prettier = {
              output = "check";
              write = true;
            };

            typos = {
              format = "long";
              diff = true;
              write = false;
            };

            yamllint = {
              configPath = ".linters/config/.yamllint.yml";
            };
          };
        };

        devcontainer.enable = true;

        devenv = {
          flakesIntegration = true;
          #warnOnNewVersion = true;
        };

        difftastic.enable = true;

        #hosts = {"example.com" = "1.1.1.1";};

        languages = {
          gawk = {enable = true;};

          nix = {enable = true;};
        };

        starship = {
          enable = true;
          package = pkgs.starship;
          config = {
            enable = true;
            path = "/home/$USER/.config/starship.toml";
          };
        };
      }
    ];
  }
