class Background : Astal.Window {
    private Gtk.Box box;
    public Background(Gdk.Monitor monitor) {
        Object(
            exclusivity: Astal.Exclusivity.IGNORE,
            layer: Astal.Layer.BACKGROUND,
            visible: true,
            gdkmonitor: monitor
        );
        Astal.widget_set_class_names (this, {"Background"});
        this.box = new Gtk.Box (Gtk.Orientation.VERTICAL, 5);
        this.box.add(new TimeLabel("%m", 300000, {"bg-month-number"}));
        this.box.add(new TimeLabel("%B", 300000, {"bg-month"}));
        this.box.add(new TimeLabel("%Y", 300000, {"bg-year"}));
        this.box.add(new TimeLabel("%H:%M", 1000, {"bg-time"}));
        add(this.box);
        show_all ();
    }
}
