{
  description = "Ben's Operating System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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
    zig-overlay.url = "github:charles37/zig-overlay";
    # ghostty.url = "github:ghostty-org/ghostty";
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
      (final: prev: let
        # 1. start from upstream vagrant but disable the embedded libvirt plugin
        base = prev.vagrant.override {withLibvirt = false;};
      in {
        # 2. add the symlink repair so `noBrokenSymlinks` passes
        vagrant = base.overrideAttrs (old: {
          # `preFixup` runs *before* the noBrokenSymlinks check
          preFixup =
            (old.preFixup or "")
            + ''
              rm -f $out/nix-support/gem-meta/spec
              # two “..” → out/         ; 3.3.0 is the gem dir for Ruby 3.3
              ln -s ../../lib/ruby/gems/3.3.0/gems/vagrant-${old.version}/vagrant.gemspec \
                     $out/nix-support/gem-meta/spec
            '';
        });
      })
      #(import ./config/system/overlays/hyprland-overlay.nix)
      (import ./config/system/overlays.nix)
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
