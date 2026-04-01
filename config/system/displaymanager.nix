{pkgs, config, ...}: {
  services.xserver = {
    enable = true;
    xkb = {
      variant = config.mySystem.theKBDVariant;
      layout = "${config.mySystem.theKBDLayout}, ${config.mySystem.theSecondKBDLayout}";
    };
    displayManager.setupCommands = ''
      xhost +local:docker
    '';
  };

  services.libinput.enable = true;

  services.displayManager.sddm = {
    enable = true;
    autoNumlock = true;
    wayland.enable = true;
    theme = "tokyo-night-sddm";
  };

  environment.systemPackages = let
    sugar = pkgs.callPackage ../pkgs/sddm-sugar-dark.nix {};
    tokyo-night = pkgs.libsForQt5.callPackage ../pkgs/sddm-tokyo-night.nix {};
  in [
    sugar.sddm-sugar-dark
    tokyo-night
    pkgs.libsForQt5.qt5.qtgraphicaleffects
  ];
}
