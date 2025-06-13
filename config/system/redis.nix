{
  config,
  pkgs,
  lib,
  ...
}: {
  services.redis.servers.local = {
    enable = true;
    port = 6379; # <‑‑ this is all you need
    bind = "127.0.0.1"; # optional but common
    # openFirewall = true;  # if you want remote hosts to connect
  };
}
