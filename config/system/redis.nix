{pkgs, ...}: {
  services.redis.servers.local = {
    enable = true; # start at boot
    openFirewall = true; # optional (localhost only if omitted)
    settings = {
      port = 6379; # default is 0 (=disabled)
      bind = "127.0.0.1"; # listen on loopback
      # Pub/Sub needs no extra config; it’s on by default
    };
  };
}
