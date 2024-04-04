{ pkgs, config, username, ... }:

#let inherit (import ../../options.nix) theKBDVariant
#theKBDLayout theSecondKBDLayout; in
let inherit (import ../../options.nix); 

in
{
  virtualisation.virtualbox.enable = true;
  users.extraGroups.vboxusers.members = [ "${username}" ];
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
}
