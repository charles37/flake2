self: super: {
  #iamb = super.callPackage ./overlays/iamb-overlay.nix {};
  #xdg-desktop-portal-hyprland = super.callPackage ./overlays/xdg-desktop-portal-hyprland-overlay.nix {};
  claude-code = super.callPackage ./overlays/claude-code-overlay.nix {};

  # Fix monitor package by using older Vala version
  monitor = super.monitor.override {
    vala = super.vala_0_56.overrideAttrs (old: rec {
      version = "0.56.17";
      src = super.fetchurl {
        url = "mirror://gnome/sources/vala/${super.lib.versions.majorMinor version}/vala-${version}.tar.xz";
        sha256 = "sha256-JhAMTk7wBJxhknXxQNl89WWIPQDHVDyCvM5aQmk07Wo=";
      };
    });
  };
}
