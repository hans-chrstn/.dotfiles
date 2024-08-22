import GLib from 'gi://GLib';
import { date } from 'lib/variables';
export default ({
  format = '%a %m/%d/%y - %H:%M:%S',
  interval = 1000,
  ...props
} = {}) =>
  Widget.Box({
    className: 'bar-clock-label',
    child: Widget.Label({
      ...props,
      label: date(interval)
        .bind('value')
        .as((date) => date.format(format) || '...')
    }),
  });
