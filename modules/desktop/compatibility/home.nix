{config, ...}: {
  # Preserve the behavior that Home Manager previously enabled implicitly.
  home.pointerCursor.enable = true;
  gtk.gtk4.theme = config.gtk.theme;
}
