class AppButton : Gtk.Button {
  private AstalApps.Application app;
  public AppButton(AstalApps.Application app) {
    this.app = app;
    this.can_focus = false;

    var box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 6);
    var icon = new Gtk.Image.from_icon_name (app.icon_name, Gtk.IconSize.BUTTON);
    box.add(icon);

    var label = new Gtk.Label(app.name);
    label.set_hexpand(true);
    label.set_ellipsize(Pango.EllipsizeMode.END);
    box.add(label);

    this.add(box);

    this.clicked.connect(() => {
      this.hide();
      app.launch();
    });
  }
}

class AppLauncher : Astal.Window {
    private AstalApps.Apps apps;
    private Gtk.Entry entry;
    private Gtk.Box box;

    public AppLauncher(Gdk.Monitor monitor) {
        Object(
            keymode: Astal.Keymode.ON_DEMAND,
            exclusivity: Astal.Exclusivity.IGNORE,
            gdkmonitor: monitor
        );

        Astal.widget_set_class_names(this, {"AppLauncher"});

        this.box = new Gtk.Box(Gtk.Orientation.VERTICAL, 6);

        this.entry = new Gtk.Entry();
        this.entry.set_placeholder_text("Search");
        this.entry.changed.connect(() => on_search_changed());
        this.box.add(this.entry);

        add(this.box);
        this.apps = new AstalApps.Apps();
        this.show_all();
    }

    private void on_search_changed() {
      var search_text = this.entry.text;
      var matched_apps = this.apps.fuzzy_query(search_text);

      var children = this.box.get_children();
      foreach (Gtk.Widget widget in children) {
        this.box.remove(widget);
      }

      foreach (var app in matched_apps) {
        var app_button = new AppButton(app);
        this.box.add(app_button);
      }

      this.show_all();
    }
}
