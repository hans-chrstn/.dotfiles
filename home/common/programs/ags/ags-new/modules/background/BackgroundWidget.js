import WeatherBackground from './WeatherBackground.js';
import DateBackground from './DateBackground.js';
import NetworkBackground from './NetworkBackground.js';

const BackgroundWidget = () => Widget.Box({
  vertical: true,
  spacing: 10,
  children: [
    Widget.Box({
      vertical: false,
      child: DateBackground()
    }),
    Widget.Box({
      vertical: false,
      children: [
        WeatherBackground(),
        NetworkBackground()
      ],
    }),
    Widget.Box({
      vertical: false,
      children: [
      ],
    }),
  ],
});

export default (monitor = 1) => Widget.Window({
  name: `background_widget${monitor}`,
  monitor,
  visible: true,
  keymode: 'none',
  anchor: ['top', 'left'],
  layer: 'background',
  child: BackgroundWidget()
});
