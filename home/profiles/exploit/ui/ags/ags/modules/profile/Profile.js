import { Widget, App } from '../../utils/imports.js';

export default () => Widget.Box({
    children: [
        Widget.Button({
            on_primary_click: () => {
                App.toggleWindow('control');
            },
            on_secondary_click: () => {
                App.closeWindow('control');
            },
            child: Widget.Icon({
                class_name: 'profile',
                icon: `${App.configDir}/assets/pfp.png`,
                size: 38,
            }),
        }),
    ],
});

