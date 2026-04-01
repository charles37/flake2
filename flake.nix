{
  description = "Ben's Operating System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    nixvim.url = "github:charles37/nixvim-new";
    impermanence.url = "github:nix-community/impermanence";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
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
    # These must be available at flake eval time (before module system)
    username = "ben";
    hostname = "nora";
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
          ./modules/options.nix
          ./modules/config.nix
          ./system.nix
          impermanence.nixosModules.impermanence
          inputs.sops-nix.nixosModules.sops
          inputs.stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          {nixpkgs.overlays = overlays;}
          {
            home-manager = {
              extraSpecialArgs = {
                inherit username;
                inherit inputs;
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
