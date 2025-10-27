{
  pkgs,
  config,
  lib,
  ...
}: {
  # Graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      #rocmPackages.clr.icd
      #TODO maybe change
    ];
  };
}
