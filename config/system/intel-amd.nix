{
  pkgs,
  config,
  lib,
  ...
}:
  lib.mkIf (config.mySystem.gpuType == "intel-amd") {
    nixpkgs.config.packageOverrides = pkgs: {
      vaapiIntel = pkgs.vaapiIntel.override {
        enableHybridCodec = true;
      };
    };

    # Graphics
    hardware.graphics = {
      extraPackages = with pkgs; [
        intel-media-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
        # RADV is enabled by default, amdvlk has been removed
      ];
      extraPackages32 = [];
    };

    systemd.tmpfiles.rules = [
      #"L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];
    services.xserver.enable = true;
    services.xserver.videoDrivers = ["amdgpu"];
  }
