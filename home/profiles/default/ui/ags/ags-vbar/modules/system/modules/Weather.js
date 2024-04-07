import { Widget } from '../../../utils/imports.js';
import WeatherService from './WeatherService.js';

export default () => Widget.Box({
    class_name: 'weather',
    children: [
        Weather(),
    ],
});

const Weather = () => Widget.EventBox({
    on_hover: (box) => {
        box.child.children[1].reveal_child = true;
    },
    on_hover_lost: (box) => {
        box.child.children[1].reveal_child = false;
    },
    child: Widget.Box({
        vertical: true,
        children: [
            Widget.Label({
                class_name: 'icon',
                label: WeatherService.bind('icon'),
            }),
            Widget.Revealer({
                reveal_child: false,
                transition: 'slide_down',
                transitionDuration: 1000,
                child: Widget.Box({
                    vertical: true,
                    children: [
                        Widget.Label({
                            class_name: 'icon_revealer',
                            label: WeatherService.bind('temp').transform(temp => temp + '')
                        }),
                    ],
                })
            }),  
        ],
    })
});

