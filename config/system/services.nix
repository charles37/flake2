{
  pkgs,
  config,
  lib,
  ...
}: {
  # List services that you want to enable:
  services.openssh.enable = true;
  services.fstrim.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal
    ];
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  hardware.pulseaudio.enable = false;
  #sound.enable = true;
  security.rtkit.enable = true;
  programs.thunar.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  services.gnome.gnome-keyring.enable = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };
  services.udev = {
    #packages = [
    #  pkgs.segger-jlink
    #];
    extraRules = builtins.concatStringsSep "\n" [
      # Tock device rules for CMSIS-DAP devices
      ''ACTION!="add|change",GOTO="openocd_rules_end"''
      ''SUBSYSTEM!="usb|tty|hidraw",GOTO="openocd_rules_end"''
      ''ATTRS[product]=="CMSIS-DAP*",MODE="664", GROUP="plugdev"''
      ''LABEL="openocd_rules_end"''
    ];
  };
}
