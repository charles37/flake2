{ pkgs, config, lib, ... }:

lib.mkIf config.mySystem.syncthing {
    services = {
        syncthing = {
        enable = true;
        user = config.mySystem.username;
        dataDir = "/home/${config.mySystem.username}";    # Default folder for new synced folders
        configDir = "/home/${config.mySystem.username}/.config/syncthing";   # Folder for Syncthing's settings and keys
        };
    };
}
