class Background : Astal.Window {
    public Background(Gdk.Monitor monitor) {
        Object(
            anchor: Astal.WindowAnchor.TOP,
            exclusivity: Astal.Exclusivity.IGNORE,
            layer: Astal.Layer.BACKGROUND,
            visible: true,
            gdkmonitor: monitor
        );
        Astal.widget_set_class_names (this, {"Background"});
        add(new TimeLabel("%H%M", 1000, {"bg-time"}));
        show_all ();
    }
}
