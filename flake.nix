{
  description = "ZaneyOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-colors.url = "github:misterio77/nix-colors";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    nixvim.url = "github:charles37/nixvim-new";
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    impermanence,
    ...
  }: let
    system = "x86_64-linux";
    inherit (import ./options.nix) username hostname;
    overlays = [
      #(import ./config/system/overlays/hyprland-overlay.nix)
    ];
    pkgs = import nixpkgs {
      inherit system overlays;
      config = {
        allowUnfree = true;
      };
    };
  in {
    nixosConfigurations = {
      "${hostname}" = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit system;
          inherit inputs;
          inherit username;
          inherit hostname;
        };
        modules = [
          ./system.nix
          impermanence.nixosModules.impermanence
          home-manager.nixosModules.home-manager
          {nixpkgs.overlays = overlays;}
          {
            home-manager = {
              extraSpecialArgs = {
                inherit username;
                inherit inputs;
                inherit (inputs.nix-colors.lib-contrib {inherit pkgs;}) gtkThemeFromScheme;
              };
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              users.${username} = import ./home.nix;
            };
          }
        ];
      };
    };
  };
}
