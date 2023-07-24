{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      # overlays = [ myAwesome.overlay ];
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          specialArgs.inputs = inputs;
          # inherit system hyprland;
          inherit system;
          modules = [
            ./configuration.nix
          #   home-manager.nixosModules.home-manager
          #  {
          #    home-manager.useGlobalPkgs = true;
          #    home-manager.useUserPackages = true;
          #    home-manager.users.byakuya = {
          #     imports = [ ./home.nix ];
          #    };
          #  }
          ];
        };
      };
    };
}


#     #  hmConfig = {
#     #    byakuya = home-manager.lib.homeManagerConfiguration {
#     #      inherit system pkgs;
#     #      username = "byakuya";
#     #      homeDirectory = "/home/byakuya";
#     #      configuration = {
#     #        imports = [
#     #          ./home.nix
#     #        ];
#     #      };
#     #    };
#     #   };
#     };
# }



# {
#   inputs.nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
#   inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
#   # inputs.home-manager = {
#   #     url = github:nix-community/home-manager;
#   #     inputs.nixpkgs.follows = "nixpkgs";
#   #   };

#   outputs = { self, nixpkgs-f2k, ... }@inputs: {
#     nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
#       system = "x86_64-linux";
#       modules = [
#         # using the nixos modules provided
#   nixpkgs-f2k.nixosModules.stevenblack # stevenblack hosts adblocking, refer to ./modules/stevenblack.nix for options

#   # using the overlays (most likely you want)
#   {
#     nixpkgs.overlays = [
#       # Check flake.nix or clone and use `nix flake show` for available subsets of overlays

#       nixpkgs-f2k.overlays.compositors # for X11 compositors
#       nixpkgs-f2k.overlays.window-managers # window managers such as awesome or river
#       nixpkgs-f2k.overlays.stdenvs # stdenvs with compiler optimizations, and library functions for optimizing them
#       # nixpkgs-f2k.overlays.default # for all packages
#     ];
#   }
#         ./configuration.nix
#            #    home-manager.nixosModules.home-manager {
#            #    home-manager.useGlobalPkgs = true;
#            #    home-manager.useUserPackages = true;
#            #   home-manager.users.byakuya = {
#            #     imports = [ ./home.nix ];
#            #   };
#            # }

#       ];
#     };
#   };
# }
