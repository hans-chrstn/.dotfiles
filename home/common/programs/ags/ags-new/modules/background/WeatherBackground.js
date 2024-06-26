import { Widget } from '../../utils/imports.js';
import WeatherService from '../services/Weather.js';
import Icons from '../icons/Icons.js';

export default () => Widget.Box({
  vertical: true,
  hpack: 'start',
  class_name: 'wb_box',
  children: [


    Widget.Box({
      vertical: false,
      children: [
        Widget.Label({
          class_name: 'weather_icon',
          label: WeatherService.bind('icon'),
        }),
        Widget.Label({
          class_name: 'weather_temp',
          label: WeatherService.bind('temp').transform(temp => temp + Icons.weather.temp.celsius),
        }),
      ],
    }),

    Widget.Box({
      vertical: false,
      children: [
        Widget.Label({
          class_name: 'weather_description',
          label: WeatherService.bind('description')
        }),
      ],
    }),

    Widget.Box({
      vertical: false,
      children: [
        Widget.Label({
          class_name: 'weather_windspeed',
          label: WeatherService.bind('windspeed').transform(wskmph => `WIND SPEED: ${wskmph}KM/H`)
        }),
      ],
    }),

    Widget.Box({
      vertical: false,
      children: [
        Widget.Label({
          class_name: 'weather_humidity',
          label: WeatherService.bind('humidity').transform(humidity => `HUMIDITY: ${humidity}%`),
        }),
      ],
    }),


  ],
});


/* export default () => Widget.Window({
  name: 'weatherbackground',
  visible: true,
  keymode: 'none',
  anchor: ['top', 'left'],
  layer: 'background',
  child: WeatherBackgroud()
}) */
