import { Widget, Utils } from '../utils/imports.js';

/* const currentTime = Glib.DateTime.new_now_local(); */

export default ({
/*     format = '%H:%M:%S %B %e, %A', */
    interval = 1000,
    class_name = 'icon',
    ...rest } = {}) => Widget.EventBox({
    on_hover: (box) => {
        box.child.children[1].reveal_child = true;
    },
    on_hover_lost: (box) => {
        box.child.children[1].reveal_child = false;
    },
    child: Widget.Box({
        vertical: true,
        children: [
            Widget.Label({
                class_name: `${class_name}`,
                ...rest,
                /*
                setup: self => self.poll(interval, () => {
                const formattedTime = currentTime.format(format) || 'wrong format';
                self.label = `${formattedTime}`;
                }) 
                */
                setup: self => self.poll(interval, self => Utils.execAsync(['date', '+%H'])
                    .then(date => self.label = date)),
            }),
            Widget.Label({
                class_name: `${class_name}`,
                ...rest,
                setup: self => self.poll(interval, self => Utils.execAsync(['date', '+%M'])
                    .then(date => self.label = date)),
            }),
            Widget.Revealer({
                reveal_child: false,
                transition: 'slide_down',
                transitionDuration: 1000,
            }),
        ],
    })
});
