{
  pkgs,
  config,
  lib,
  ...
}: {
  services.grafana = {
    enable = true;
    settings = {
      server = {
        # Listening Address
        http_addr = "127.0.0.1";
        # and Port
        http_port = 3000;
        # Grafana needs to know on which domain and URL it's running
        root_url = "https://monitoring.googleapis.com/v1/projects/clockwin-1/location/global/prometheus/api/v1/write"; # Not needed if it is `https://your.domain/`
        serve_from_sub_path = true;
      };
    };
  };
}
