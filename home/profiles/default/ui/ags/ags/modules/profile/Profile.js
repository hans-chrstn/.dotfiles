import { Widget, App } from '../../utils/imports.js';

export default () => Widget.Button({
    child: Widget.Icon({
        class_name: 'profile',
        icon: `${App.configDir}/assets/pfp.png`,
        size: 38,
    }),
    on_clicked: () => {

    },
});
