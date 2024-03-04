{ pkgs, config, username, ... }:

#let inherit (import ../../options.nix) theKBDVariant
#theKBDLayout theSecondKBDLayout; in
let inherit (import ../../options.nix); 

in
{
  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = [ "${username}" ];
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
}


