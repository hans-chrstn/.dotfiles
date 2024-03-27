import { Widget } from '../../../utils/imports.js';
import WeatherService from './WeatherService.js';

export default () => Widget.Box({
    class_name: "weather",
    children: [
        Widget.Label({
            class_name: 'icon',
            label: WeatherService.bind('icon'),
        }),
        Weather(),
    ],
    tooltip_markup: WeatherService.bind('description')
});

const Weather = () => Widget.Box({
    child: Widget.Revealer({
        reveal_child: false,
        transition: 'slide_left',
        attribute: { count: 0 },
        setup: self => {
            self.hook(WeatherService, (self) => {
                self.reveal_child = true
                self.attribute.count++
                Utils.timeout(4000, () => {
                    self.attribute.count--
                    if (self.attribute.count === 0) self.reveal_child = false
                })
            })
        },
        child: Widget.Box({
            class_name: 'temp',
            children: [
                Widget.Label({
                    class_name: 'icon',
                    label: WeatherService.bind('temp').transform(temp => temp + '')
                }),
            ],
        })
    })

});

