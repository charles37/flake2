{ pkgs, config, username, ... }:

#let inherit (import ../../options.nix) theKBDVariant
#theKBDLayout theSecondKBDLayout; in
let inherit (import ../../options.nix); 

in
{
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "${username}" ];
  virtualisation.virtualbox.host.enableExtensionPack = true;
}
