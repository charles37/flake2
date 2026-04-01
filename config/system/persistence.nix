{ config, pkgs, lib, username, ... }:

{
  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      "/etc/ssh"
    ];
    files = [
      # "/etc/machine-id"
    ];
    users.${username} = {
      directories = [
	"Downloads"
	"Music"
	"Documents"
	"Pictures"
        "Videos"
        "zaneyos"
	".local/share/sddm"
	".mozilla"
	".cache"
	".ssh"
	".config/discord"
	".config/obs-studio"
	".config/sops"
	".steam"
      ];
      files = [
      ];
    };
  };
}
