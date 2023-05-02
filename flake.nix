{
  description = "docs";

  inputs = {
    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-22.11";
      flake = true;
    };

    nixpkgs-unstable = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-unstable";
      flake = true;
    };

    # https://devenv.sh/
    devenv = {
      type = "github";
      owner = "cachix";
      repo = "devenv";
      ref = "main";
      flake = true;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fenix = {
      type = "github";
      owner = "nix-community";
      repo = "fenix";
      ref = "main";
      flake = true;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    devenv,
    fenix,
    ...
  } @ inputs: let
    buildSystem = "x86_64-linux";

    hostSystems = [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-darwin"
      "x86_64-linux"
    ];

    _targets = [
      "aarch64-apple-darwin"
      "aarch64-unknown-linux-gnu"
      "i686-unknown-linux-gnu"
      "x86_64-apple-darwin"
      "x86_64-unknown-linux-gnu"
    ];

    forAllSystems = f:
      builtins.listToAttrs (map (name: {
          inherit name;
          value = f name;
        })
        hostSystems);

    pkgsImportSystem = system:
      import nixpkgs {
        inherit system;
      };

    pkgsImportSystemUnstable = system:
      import inputs.nixpkgs-unstable {inherit system;};

    _pkgsImportCrossSystem = buildPlatform: hostPlatform:
      if buildPlatform == hostPlatform
      then
        import inputs.nixpkgs {
          system = buildPlatform;
          localSystem = buildPlatform;
          crossSystem = buildPlatform;
        }
      else
        import inputs.nixpkgs {
          system = buildPlatform;
          localSystem = buildPlatform;
          crossSystem = hostPlatform;
        };

    _pkgsAllowUnfree = {
      nixpkgs = {
        config = {
          allowUnfree = true;
          allowUnfreePredicate = _: true;
        };
      };
    };
  in {
    devShells = forAllSystems (hostPlatform: let
      # Build Platform
      system = buildSystem;
      inherit (self.packages.${system}) default;
      pkgs = pkgsImportSystem system;
      pkgsUnstable = pkgsImportSystemUnstable system;
    in {
      devenv = import ./nix/devshells/devenv {
        inherit inputs;
        inherit pkgs;
        inherit pkgsUnstable;
      };

      default = self.devShells.${system}.devenv;
    });
  };
}
