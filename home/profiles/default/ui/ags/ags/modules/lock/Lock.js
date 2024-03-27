import { Utils } from '../../utils/imports.js';
import PowerButton from './utils/PowerButton.js'

export default () => Widget.Box({
    class_name: 'sys_powerbar',
    children: [
        Reboot(),
        Shutdown(),
        Lock(),
        Suspend(),
        Logout(),
    ],
});



const Lock = () => PowerButton({
    class_name: 'icon',
    on_clicked: () => Utils.execAsync('hyprlock'),
    label: ''
});

const Reboot = () => PowerButton({
    class_name: 'icon',
    on_clicked: () => Utils.execAsync(['systemctl', 'reboot']),
    label: ''
});

const Suspend = () => PowerButton({
    class_name: 'icon',
    on_clicked: () => Utils.execAsync(['systemctl', 'suspend']),
    label: '⏾'
});

const Shutdown = () => PowerButton({
    class_name: 'icon',
    on_clicked: () => Utils.execAsync(['shutdown', '-h', 'now']),
    label: '⏻'
});

const Logout = () => PowerButton({
    class_name: 'icon',
    on_clicked: () => Utils.execAsync(['loginctl', 'terminate-user', '$USER']),
    label: '󰍃'
});
