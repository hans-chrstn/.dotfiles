import { Utils } from '../../utils/imports.js';
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



const Lock = () => Widget.Box({
    class_name: 'icon',
    children: [
        Widget.Button({
            on_clicked: () => Utils.execAsync('hyprlock'),
            child: Widget.Label({
                label: ''
            }) 
        }),
    ],
});

const Reboot = () => Widget.Box({
    class_name: 'icon',
    children: [
        Widget.Button({
            on_clicked: () => Utils.execAsync('hyprlock'),
            child: Widget.Label({
                label: ''
            }) 
        }),
    ],
});

const Suspend = () => Widget.Box({
    class_name: 'icon',
    children: [
        Widget.Button({
            on_clicked: () => Utils.execAsync('hyprlock'),
            child: Widget.Label({
                label: '⏾'
            }) 
        }),
    ],
});

const Shutdown = () => Widget.Box({
    class_name: 'icon',
    children: [
        Widget.Button({
            on_clicked: () => Utils.execAsync('hyprlock'),
            child: Widget.Label({
                label: '⏻'
            }) 
        }),
    ],
});

const Logout = () => Widget.Box({
    class_name: 'icon',
    children: [
        Widget.Button({
            on_clicked: () => Utils.execAsync('hyprlock'),
            child: Widget.Label({
                label: '󰍃'
            }) 
        }),
    ],
});
