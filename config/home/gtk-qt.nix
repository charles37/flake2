{pkgs, config, ...}: {
  # Stylix handles cursor, GTK theme, and QT theme automatically.
  # We only need to set icon theme and dark preference overrides here.

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.theme = null;
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
}
