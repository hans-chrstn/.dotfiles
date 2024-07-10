import { Widget } from '../../lib/Imports.js';

const BottomLeft = () => Widget.Box({
    class_name: 'bottom_left_bar',
    homogeneous: false,
    vertical: false,
    hpack: 'start',
    children: [
    ],
});

const BottomCenter = () => Widget.Box({
    class_name: 'bottom_center_bar',
    homogeneous: false,
    vertical: false,
    hpack: 'center',
    children: [
    ],
});

const BottomRight = () => Widget.Box({
    class_name: 'bottom_right_bar',
    homogeneous: false,
    vertical: false,
    hpack: 'end',
    children: [
    ],

});

export default (monitor = 0) => Widget.Window({
    anchor: ['bottom', 'left', 'right'],
    name: `bottom_bar${monitor}`,
    monitor,
    exclusivity: 'exclusive',
    child: Widget.CenterBox({
        class_name: 'bar_layout',
        start_widget: BottomLeft(),
        center_widget: BottomCenter(),
        end_widget: BottomRight(), 
    })
});

