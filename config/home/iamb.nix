{
  pkgs,
  config,
  ...
}: {
  home.file.".config/iamb/config.toml".text = ''
    [profiles.user]
    user_id = "@bpre:matrix.org"
  '';
  # https://iamb.chat/configure.html
}
