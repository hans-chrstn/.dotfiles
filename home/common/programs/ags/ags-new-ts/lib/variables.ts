import GLib from 'gi://GLib';

export function date(interval: number) {
  return Variable(GLib.DateTime.new_now_local(), {
    poll: [interval, () => GLib.DateTime.new_now_local()],
  })
}

export const uptime = (interval: number) => Variable(0, {
    poll: [interval, 'cat /proc/uptime', line =>
      Number.parseInt(line.split('.')[0]) / 3600 ]
})
