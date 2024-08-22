import { App, Widget, Battery } from '../../../../utils/imports.js';

const Resource = () => Widget.Box({
    class_name: 'resource_box',
    vertical: true,
    child: Widget.Box({
        class_name: 'resource_box2',
        vertical: false,
        children: [
            Widget.CircularProgress({
                class_name: 'resource_battery',
                rounded: false,
                inverted: false,
                startAt: 0.75,
                value: Battery.bind('percent').as(p => p / 100),
            }),
        ],
    }),
});

export default () => Widget.Window({
    name: 'resource',
    anchor: ['top', 'right'],
    visible: false,
    keymode: 'on-demand',
    setup: self => self.keybind('Escape', () => {
        App.closeWindow('resource');
    }),
    child: Resource()
});
