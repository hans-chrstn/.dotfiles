import Glib from "types/@girs/glib-2.0/glib-2.0";
import { clock } from "lib/Variables";
export default ({
  format = "%a %m/%d/%y - %H:%M:%S",
  interval = 1000,
  ...props
} = {}) =>
  Widget.Box({
    cssClasses: ["bar-clock"],
    child: Widget.Label({
      ...props,
      cssClasses: ["bar-clock-label"],
      label: clock(interval)
        .bind("value")
        .as((date) => date.format(format) || "..."),
    }),
  });
