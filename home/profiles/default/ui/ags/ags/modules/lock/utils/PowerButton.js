import { Widget, Utils } from '../../../utils/imports.js';

export default ({
    class_name = 'sys_powerbar_icons',
    on_clicked = () => Utils.execAsync('hyprlock'),
    label = 'default',
    ...rest } = {}) => Widget.Box ({
    class_name: `${class_name}`,
    ...rest,
    child: Widget.Button({
        cursor: 'pointer',
        on_clicked: on_clicked,
        child: Widget.Label({
            label: label
        })
    })
});
