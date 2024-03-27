import { Widget } from '../../utils/imports.js';

export default () => Widget.Box({
    class_name: 'workspaces',
    child: Widget.Icon({
        class_name: 'workspaces_icon',
        icon: `${App.configDir}/assets/static_cat.png`,
        size: 38,
    })
});
