{
  description = "Jonatan's M1 Environment";

  nixConfig = {
    extra-substituters = [
      "https://cachix.cachix.org"
      "https://nix-community.cachix.org"
      "https://hydra.iohk.io"
      "https://iohk.cachix.org"
      "https://cache.nixos.org/"
      "https://accio.cachix.org"
    ];

    extra-trusted-public-keys = [
      "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo="
    ];
  };

  inputs = {
    unstable.url = "github:nixos/nixpkgs/master";
    nur.url = "github:nix-community/NUR";
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "unstable";
    };

    # Editors
    neovim = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "unstable";
    };

    # emacs-overlay = {
    #   url =
    #     "github:nix-community/emacs-overlay/";
    #   inputs.nixpkgs.follows = "unstable";
    # };

    emacs = {
      url = "github:shaunsingh/emacs";
      inputs.nixpkgs.follows = "unstable";
    };

    doom-emacs = {
      url = "github:hlissner/doom-emacs/develop";
      flake = false;
    };

    alacritty-src = {
      url = "github:zenixls2/alacritty/ligature";
      flake = false;
    };

    yabai-src = {
      url = "github:koekeishiya/yabai";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager, nur, neovim, emacs
    , doom-emacs, yabai-src, ... }:
    let
      system = "aarch64-darwin";

      pkgs = import nixpkgs {
        inherit system;
        allowBroken = true;
        allowUnsupportedSystem = true;
      };

      nixpkgsWithOverlays = {
        nixpkgs = {
          overlays = [
            nur.overlay
            neovim.overlay
            emacs.overlay
            (final: prev: { doomEmacsRevision = doom-emacs.rev; })
          ];
          config.allowUnfree = true;
        };
      };

      bowtruckle = self.darwinConfigurations.bowtruckle.system;

    in {
      inherit bowtruckle;
      darwinConfigurations = {
        bowtruckle = darwin.lib.darwinSystem {
          inherit system;
          modules = [
            nixpkgsWithOverlays
            ./modules/alacritty
            ./modules/pam
            ./modules/git
            ./modules/mac
            ./modules/fonts
            ./modules/shells
            ./modules/direnv
            ./modules/firefox
            ./modules/neovim
            ./modules/emacs
            ./hosts/bowtruckle.nix
            home-manager.darwinModule
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
              };
            }
            ./modules/full.nix
          ];
        };
      };
    };

}
