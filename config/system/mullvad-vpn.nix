{
  config,
  pkgs,
  lib,
  ...
}: {
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn; # This includes the GUI application
  };

  # Enable systemd-resolved as it's currently required for Mullvad VPN to work
  services.resolved.enable = true;

  # Optionally, you can add firewall rules to only allow traffic through Mullvad VPN
  # networking.firewall = {
  #   allowedUDPPorts = [ 53 1194 1195 1196 1197 1300 1301 1302 1303 1400 ];
  #   allowedTCPPorts = [ 53 1401 ];
  # };
}
