import Weather from 'services/weather';
import Icons from 'lib/icons';

const Temperature = () => Widget.Box({
  vertical: false,
  children: [
    Widget.Label({
      className: 'bweather-icon',
      label: Weather.bind('icon'),
    }),
    Widget.Label({
      className: 'bweather-temp',
      label: Weather.bind('temp').transform(t => t + Icons.weather.temp.celsius),
    }),
  ],
});

const Description = () => Widget.Box({
  vertical: false,
  children: [
    Widget.Label({
      className: 'bweather-desc',
      label: Weather.bind('description'),
      maxWidthChars: 18,
    }),
  ],
});

const Windspeed = () => Widget.Box({
  vertical: false,
  children: [
    Widget.Label({
      className: 'bweather-windspeed',
      label: Weather.bind('windspeed').transform(ws => `WINDSPEED: ${ws}KM/H`),
    }),
  ],
});

const Humidity = () => Widget.Box({
  vertical: false,
  children: [
    Widget.Label({
      className: 'bweather-humidity',
      label: Weather.bind('humidity').transform(h => `HUMIDITY: ${h}%`)
    }),
  ],
});

export default () => Widget.Box({
  vertical: true,
  className: 'bweather',
  hpack: 'start',
  children: [
    Temperature(),
    Description(),
    Windspeed(),
    Humidity(),
  ],
});
