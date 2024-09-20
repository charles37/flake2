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
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];
    services.xserver.enable = true;
    services.xserver.videoDrivers = ["amdgpu"];
    environment.variables = {
      # As of ROCm 4.5, AMD has disabled OpenCL on Polaris based cards. So this is needed if you have a 500 series card.
      ROC_ENABLE_PRE_VEGA = "1";
    };
    # OpenGL
    hardware.opengl = {
      ## amdvlk: an open-source Vulkan driver from AMD
      extraPackages32 = [pkgs.driversi686Linux.amdvlk];
      enable = true;
      extraPackages = with pkgs; [
        pkgs.amdvlk
        rocmPackages_5.clr.icd
        rocmPackages_5.clr
        rocmPackages_5.rocminfo
        rocmPackages_5.rocm-runtime
      ];
    };
  }
