{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (import ../../options.nix) gpuType;
in
  lib.mkIf ("${gpuType}" == "amd") {
    systemd.tmpfiles.rules = [
      #"L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];
    services.xserver.enable = true;
    services.xserver.videoDrivers = ["amdgpu" "modesetting"];
    environment.variables = {
      # As of ROCm 4.5, AMD has disabled OpenCL on Polaris based cards. So this is needed if you have a 500 series card.
      ROC_ENABLE_PRE_VEGA = "1";
    };
    # Graphics (RADV is enabled by default for AMD)
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        # RADV is enabled by default, amdvlk has been removed
        # rocmPackages_5.clr.icd
        # rocmPackages_5.clr
        # rocmPackages_5.rocminfo
        # rocmPackages_5.rocm-runtime
      ];
      extraPackages32 = [];
    };
  }
