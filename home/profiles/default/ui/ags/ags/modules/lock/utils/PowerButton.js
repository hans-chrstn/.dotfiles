import { Utils } from '../../../utils/imports.js';

export default ({
    class_name = 'default',
    on_clicked = () => Utils.execAsync('hyprlock'),
    label = 'default',
    ...rest } = {}) => Widget.Box ({
        class_name: `${class_name}`,
        ...rest,
        child: Widget.Button({
            on_clicked: on_clicked,
            child: Widget.Label({
                label: label
            })
        })
         
    });
