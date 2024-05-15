import { SystemLeft, SystemRight } from './modules/system/System.js';
import Profile from './modules/profile/Profile.js';
import { Widget } from './utils/imports.js';

const Left = () => Widget.Box({
    class_name: 'left_vbar',
    homogeneous: false,
    vertical: true,
    vpack: 'end',
    children: [
        SystemLeft(),
        SystemRight(),
        Profile(),
    ],
});

const Center = () => Widget.Box({
    class_name: 'center_vbar',
    homogeneous: false,
    vertical: true,
    vpack: 'center',
    children: [
    ],
});

const Right = () => Widget.Box({
    class_name: 'right_vbar',
    homogeneous: false,
    vertical: true,
    vpack: 'start',
    children: [
    ],

});

export default (monitor = 0) => Widget.Window({
    anchor: ['bottom', 'left', 'top'],
    name: `vbar${monitor}`,
    monitor,
    exclusivity: 'exclusive',
    child: Widget.CenterBox({
        class_name: 'vbar_layout',
        start_widget: Right(),
        center_widget: Center(),
        end_widget: Left(), 
    })
});

