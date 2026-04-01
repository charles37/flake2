{
  pkgs,
  config,
  username,
  ...
}:
{
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = ["${username}"];
  virtualisation.virtualbox.host.enableExtensionPack = true;
}
