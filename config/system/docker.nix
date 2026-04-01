{
  pkgs,
  config,
  username,
  ...
}:
{
  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = ["${username}"];
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
}
