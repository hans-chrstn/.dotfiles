import { App, Notifications, Utils, Widget } from '../../../../utils/imports.js';
import Icon from '../../../icons/icons.js';

const Noisy = () => Widget.Label({
    label: Icon.notification.noisy,
    class_name: 'icon',
    visible: Notifications.bind('notifications').transform(notf => notf.length > 0),
});

const DnD = () => Widget.Label({
    label: Icon.notification.dnd,
    class_name: 'icon',
    visible: Notifications.bind('dnd')
});

const NotificationIndicator = () => Widget.Box({
    class_name: 'notification_indicator',
    children: [
        Noisy(),
        DnD(),
    ],
});

const ControlProfile = () => Widget.Icon({
    icon: `${App.configDir}/assets/pfp.png`,
    size: 28,
});



const Control = () => Widget.Box({
    class_name: 'control_box',
    vertical: true,
    children: [
        Widget.Box({
            class_name: 'control_box2',
            vertical: false,
            child: Widget.CenterBox({
                start_widget: ControlProfile(),
                center_widget: Widget.Button({
                    child: Widget.Label({
                        class_name: 'control_profile_label',
                        label: 'hansestallo@gmail.com',
                    })
                }),
                end_widget: NotificationIndicator(),
            })
        }),
        Widget.Box({
            class_name: 'control_box2',
            vertical: false,
            children: [
                Widget.Button({
                    on_clicked: () => {
                        Utils.execAsync(['hyprctl', 'reload']);
                    },
                    child: Widget.Label({
                        class_name: 'icon',
                        label: Icon.reload,
                    })
                }),
            ],
        }),
    ],
});

export default () => Widget.Window({
    name: 'control',
    visible: false,
    keymode: 'on-demand',
    anchor: ['top', 'right'],
    setup: self => self.keybind('Escape', () =>{
        App.closeWindow('control');
    }),
    child: Control(),
});
