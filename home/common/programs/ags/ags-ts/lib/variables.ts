import GLib from 'gi://GLib';

export function date(interval: number) {
  return Variable(GLib.DateTime.new_now_local(), {
    poll: [interval, () => GLib.DateTime.new_now_local()],
  })
}
