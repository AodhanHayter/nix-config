{
  description = "NixOS configuration";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    hardware.url = "github:nixos/nixos-hardware";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Nix Darwin
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # TODO: Add any other flake you might need
  };

  outputs = { nixpkgs, home-manager, darwin, ... }@inputs: rec {
    legacyPackages = nixpkgs.lib.genAttrs [ "x86_64-linux" "x86_64-darwin" "aarch64-darwin" ] (system:
      import inputs.nixpkgs {
        inherit system;
        # NOTE: Using `nixpkgs.config` in your NixOS config won't work
        # Instead, you should set nixpkgs configs here
        # (https://nixos.org/manual/nixpkgs/stable/#idm140737322551056)

        config.allowUnfree = true;
      }
    );

    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        pkgs = legacyPackages.x86_64-linux;
        specialArgs = { inherit inputs; }; # Pass flake inputs to our config
        # > Our main nixos configuration file <
        modules = [ ./nixos/configuration.nix ];
      };
    };

    darwinConfigurations = {
      "ahayter-mbp" = darwin.lib.darwinSystem {
        pkgs = legacyPackages.aarch64-darwin;
        specialArgs = { inherit inputs; }; # Pass flake inputs to our config
        modules = [ ./macos/configuration.nix ];
      };
    };

    homeConfigurations = {
      "aodhan@nixos" =
        home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs; }; # Pass flake inputs to our config
          # > Our main home-manager configuration file <
          modules = [ ./home-manager/home.nix ];
        };

      "ahayter@ahayter-mbp" = home-manager.lib.homeManagerConfiguration {
        pkgs = legacyPackages.aarch64-darwin;
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./macos/home-manager/home.nix ];
      };
    };
  };
}
