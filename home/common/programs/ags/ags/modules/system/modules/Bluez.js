import { Bluetooth, Widget, Utils } from '../../../utils/imports.js';
import Icon from '../../icons/icons.js';

export default () => Widget.EventBox({
    on_hover: (box) => {
        box.child.children[1].reveal_child = true;
    },
    on_hover_lost: (box) => {
        box.child.children[1].reveal_child = false;
    },
    on_primary_click: () => {
        Utils.execAsync(['bluetooth']).then(output => {
            const status = output.trim().split('=')[1].trim();
            const newStatus = (status === 'on') ? 'off' : 'on';
            Utils.execAsync(['bluetooth', newStatus]);
        }); 
    },
    child: Widget.Box({
        children: [
            Widget.Label({
                class_name: 'icon',
                setup: self => {
                    self.hook(Bluetooth, (self) => {
                        self.label = !Bluetooth.enabled ? 
                            Icon.bluetooth.disabled : Icon.bluetooth.enabled;
                    });
                },
            }),
            Widget.Revealer({
                reveal_child: false,
                transition: 'slide_left',
                transitionDuration: 1000,
                child: Widget.Button({
                    on_clicked: () => {
                        Utils.execAsync('blueman-manager');
                    },
                    child: Widget.Label({
                        label: Bluetooth.bind('name').transform(bn => bn || 'N/A'),
                    })
                })
            }),
        ],
    })
});
