public class TimeLabel : Astal.Label {
  string format;
  AstalIO.Time interval;

  void sync() {
      label = new DateTime.now_local().format(format);
  }

  public TimeLabel(string format = "%a %m/%d/%y - %H:%M:%S") {
      this.format = format;
      interval = AstalIO.Time.interval(1000, null);
      interval.now.connect(sync);
      destroy.connect(interval.cancel);
      Astal.widget_set_class_names(this, {"Time"});
  }
}
