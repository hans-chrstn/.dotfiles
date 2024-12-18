class Left : Astal.Box {
  public Left() {
    Object(hexpand: true, halign: Gtk.Align.START);
  }
}

class Center : Astal.Box {
  public Center() {
    Object(hexpand: true, halign: Gtk.Align.CENTER);
    add(new TimeLabel());
  }
}

class Right : Astal.Box {
  public Right() {
    Object(hexpand: true, halign: Gtk.Align.END);
  }
}

class Bar : Astal.Window {
    public Bar(Gdk.Monitor monitor) {
        Object(
            anchor: Astal.WindowAnchor.TOP
                | Astal.WindowAnchor.LEFT
                | Astal.WindowAnchor.RIGHT,
            exclusivity: Astal.Exclusivity.EXCLUSIVE,
            gdkmonitor: monitor
        );

        Astal.widget_set_class_names(this, {"Bar"});

        add(new Astal.CenterBox() {
            start_widget = new Left(),
            center_widget = new Center(),
            end_widget = new Right(),
        });

        show_all();
    }
}
