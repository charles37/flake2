{
  pkgs,
  config,
  ...
}: {
  home.file.".config/iamb/config.toml".text = ''
    [profiles.user]
    user_id = "@bpre:matrix.org"
    [settings.notifications]
    enabled = true
    show_mesage = true
    via = "desktop"
    [settings.image_preview]
    protocol.type = "halfblocks"
    protocol.font_size = [ 11, 26 ]
  '';
  # https://iamb.chat/configure.html
}
