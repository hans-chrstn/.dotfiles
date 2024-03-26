import Glib from 'gi://GLib';

export default ({
    format = '%H:%M:%S %B %e, %A',
    interval = 1000,
    class_name = 'clock',
    ...rest } = {}) => Widget.Label({
        class_name: `${class_name}`,
        ...rest,
        setup: self => self.poll(interval, () => {
            self.label = Glib.DateTime.new_now_local().format(format) || 'wrong format';
        }),
    });

