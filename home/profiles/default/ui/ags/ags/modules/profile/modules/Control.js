import { Widget } from '../../../utils/imports.js';

const control = Widget.Window({
    class_name: 'control',
    anchor: ['top', 'right'],
    child: Widget.Box({
        children: [
            Widget.Label({
                label: 'test',
            }),
        ],
    })
});

export { control };
