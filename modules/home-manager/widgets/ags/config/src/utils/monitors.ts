import Gdk from 'gi://Gdk';

export function range(length: number, start: number = 1): number[] {
  return Array.from({ length }, (_, i) => i + start);
}

export function forMonitors(widget: (monitor: number) => JSX.Element) {
  const n = Gdk.Display.get_default()?.get_n_monitors() || 1;
  return range(n, 0).map(widget).flat(1);
}
