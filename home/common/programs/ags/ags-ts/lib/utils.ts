import Gdk from 'gi://Gdk';
import Gtk from 'gi://Gtk?version=3.0';

export function range(length: number, start: number = 1) {
  return Array.from({ length }, (_, i) => i + start);
}

export function forMonitors(widget: (monitor: number) => Gtk.Window) {
  const n = Gdk.Display.get_default()?.get_n_monitors() || 1;
  return range(n, 0).map(widget).flat(1);
}
