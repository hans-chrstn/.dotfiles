import { Utils, Widget } from '../../utils/imports.js';
import PowerButton from './utils/PowerButton.js';

export default () => Widget.Box({
    class_name: 'sys_powerbar',
    children: [
        PowerMenu(),
    ],
});


const PowerMenu = () => Widget.EventBox({
    on_hover: (box) => {
        box.child.children[0].reveal_child = true;
    },
    on_hover_lost: (box) => {
        box.child.children[0].reveal_child = false;
    },
    child: Widget.Box({
        children: [
            Widget.Revealer({
                reveal_child: false,
                transition: 'crossfade',
                transitionDuration: 1000,
                child: Widget.Box({
                    children: [
                        Reboot(),
                        Shutdown(),
                        Lock(),
                        Suspend(),
                        Logout(),
                    ],
                })
            })
        ], 
    })
});

const Lock = () => PowerButton({
    on_clicked: () => Utils.execAsync(['hyprlock', '-c', '~/.dotfiles/home/common/programs/hyprland/config/hyprlock.conf']),
    label: ''
});

const Reboot = () => PowerButton({
    on_clicked: () => Utils.execAsync(['systemctl', 'reboot']),
    label: ''
});

const Suspend = () => PowerButton({
    on_clicked: () => Utils.execAsync(['systemctl', 'suspend']),
    label: '⏾'
});

const Shutdown = () => PowerButton({
    on_clicked: () => Utils.execAsync(['shutdown', '-h', 'now']),
    label: '⏻'
});

const Logout = () => PowerButton({
    on_clicked: () => Utils.execAsync(['bash', '-c', 'loginctl terminate-user $USER']),
    label: '󰍃'
});
