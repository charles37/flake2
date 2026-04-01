{
  pkgs,
  config,
  ...
}: let
  palette = config.lib.stylix.colors;
in {
  home.packages = [pkgs.hyprlock];

  home.file.".config/hypr/hyprlock.conf".text = ''
    general {
      hide_cursor = true
      grace = 5
    }

    background {
      monitor =
      path = ~/.config/swaylock-bg.jpg
      blur_passes = 3
      blur_size = 8
      brightness = 0.6
    }

    input-field {
      monitor =
      size = 300, 50
      outline_thickness = 3
      dots_size = 0.25
      dots_spacing = 0.15
      dots_center = true
      outer_color = rgb(${palette.base0D})
      inner_color = rgb(000000)
      font_color = rgb(${palette.base05})
      fade_on_empty = true
      placeholder_text = <i>Password...</i>
      hide_input = false
      check_color = rgb(${palette.base0D})
      fail_color = rgb(${palette.base08})
      fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i>
      capslock_color = rgb(${palette.base0A})
      position = 0, -20
      halign = center
      valign = center
    }

    label {
      monitor =
      text = cmd[update:1000] echo "<b><big>$(date +"%H:%M")</big></b>"
      color = rgb(${palette.base05})
      font_size = 64
      font_family = Ubuntu
      position = 0, 80
      halign = center
      valign = center
    }

    label {
      monitor =
      text = cmd[update:1000] echo "$(date +"%A, %B %d")"
      color = rgb(${palette.base05})
      font_size = 20
      font_family = Ubuntu
      position = 0, 160
      halign = center
      valign = center
    }
  '';
}
