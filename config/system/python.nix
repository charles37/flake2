{ pkgs, config, lib, ... }:

let
  my-python-packages = ps: with ps; [
    pandas
    requests
  ];
in lib.mkIf config.mySystem.python {
  environment.systemPackages = with pkgs; [
    jetbrains.pycharm-community-bin
    (pkgs.python3.withPackages my-python-packages)
  ];

}
