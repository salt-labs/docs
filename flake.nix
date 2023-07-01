{
  description = "docs";

  inputs = {
    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-23.05";
      flake = true;
    };

    nixpkgs-unstable = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-unstable";
      flake = true;
    };

    devenv = {
      type = "github";
      owner = "cachix";
      repo = "devenv";
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
    ...
  } @ inputs: let
    supportedSystems = [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-darwin"
      "x86_64-linux"
    ];

    _targets = [
      "aarch64-apple-darwin"
      "aarch64-unknown-linux-gnu"
      "x86_64-apple-darwin"
      "x86_64-unknown-linux-gnu"
    ];

    forAllSystems = f:
      builtins.listToAttrs (map (buildPlatform: {
          name = buildPlatform;
          value = builtins.listToAttrs (map (hostPlatform: {
              name = hostPlatform;
              value = f buildPlatform hostPlatform;
            })
            supportedSystems);
        })
        supportedSystems);

    pkgsImportCrossSystem = buildPlatform: hostPlatform:
      import nixpkgs {
        system = buildPlatform;
        overlays = [];
        config = {
          allowUnfree = true;
          allowUnfreePredicate = _: true;
        };
        crossSystem =
          if buildPlatform == hostPlatform
          then null
          else {
            config = hostPlatform;
          };
      };

    pkgsImportCrossSystemUnstable = buildPlatform: hostPlatform:
      import nixpkgs-unstable {
        system = buildPlatform;
        overlays = [];
        config = {
          allowUnfree = true;
          allowUnfreePredicate = _: true;
        };
        crossSystem =
          if buildPlatform == hostPlatform
          then null
          else {
            config = hostPlatform;
          };
      };

    flattenPackages = systems:
      builtins.foldl' (acc: system:
        builtins.foldl' (
          innerAcc: hostPlatform:
            innerAcc // {"${system}.${hostPlatform}" = systems.${system}.${hostPlatform};}
        )
        acc (builtins.attrNames systems.${system})) {} (builtins.attrNames systems);
  in {
    ###############
    ## DevShells
    ###############

    devShells = flattenPackages (forAllSystems (buildPlatform: hostPlatform: let
      # Build Platform
      system = buildPlatform;
      pkgs = pkgsImportCrossSystem buildPlatform buildPlatform;
      pkgsUnstable = pkgsImportCrossSystemUnstable buildPlatform buildPlatform;

      # Host Platform
      crossPkgs = pkgsImportCrossSystem buildPlatform hostPlatform;
      crossPkgsUnstable = pkgsImportCrossSystemUnstable buildPlatform hostPlatform;
    in {
      devenv = import ./nix/devshells/devenv {
        inherit inputs;
        inherit system;
        inherit pkgs;
        inherit pkgsUnstable;
        inherit crossPkgs;
        inherit crossPkgsUnstable;
      };
    }));

    # Set the default devshell to the one for the current system.
    devShell = builtins.listToAttrs (map (system: {
        name = system;
        value = self.devShells."${system}.${system}".devenv;
      })
      supportedSystems);
  };
}
