class TimeLabel : Astal.Label {
    private string _format;
    private AstalIO.Time _interval;
    private string[] _className;

    void sync() {
        label = new DateTime.now_local().format(_format);
    }

    public TimeLabel(string format = "%a %m/%d/%y - %H:%M:%S", int interval = 1000, string[] className = {"Time"}) {
        this._format = format;
        this._interval = AstalIO.Time.interval(interval, null);
        this._interval.now.connect(sync);
        destroy.connect(_interval.cancel);
        Astal.widget_set_class_names(this, className);
        sync();
    }
}
