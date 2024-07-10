import Weather from 'services/Weather';
import Icon from 'lib/Icons';

export default () => Widget.Box({
  cssClasses: ['bweather-box'],
  vertical: true,
  hpack: 'start',
  children: [
    Widget.Box({
      vertical: false,
      children: [
        Widget.Label({
          cssClasses: ['bweather-icon'],
          label: Weather.bind('icon'),
        }),
        Widget.Label({
          cssClasses: ['bweather-temp'],
          label: Weather.bind('temp').transform(t => t + Icon.weather.temp.celsius),
        }),
      ],
    }),
    Widget.Box({
      vertical: false,
      children: [
        Widget.Label({
          cssClasses: ['bweather-desc'],
          label: Weather.bind('description'),
        }),
      ],
    }),
    Widget.Box({
      vertical: false,
      children: [
        Widget.Label({
          cssClasses: ['bweather-windspeed'],
          label: Weather.bind('windspeed').transform(ws => `WINDSPEED: ${ws}KM/H`),
        }),
      ],
    }),
    Widget.Box({
      vertical: false,
      children: [
        Widget.Label({
          cssClasses: ['bweather-humidity'],
          label: Weather.bind('humidity').transform(hd => `HUMIDITY: ${hd}%`),
        }),
      ],
    })
  ],
});
