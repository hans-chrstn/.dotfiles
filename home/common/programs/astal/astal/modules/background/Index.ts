import BDate from './modules/BDate';
import BWeather from './modules/BWeather';
import BNetwork from './modules/BNetwork';
const Background = () => Widget.Box({
  vertical: true,
  spacing: 30,
  children: [
    Widget.Box({
      vertical: false,
      child: BDate(),
    }),
    Widget.Box({
      vertical: false,
      children: [
        BWeather(),
        BNetwork(),
      ],
    }),
  ],
});

export default () => Widget.Window({
  name: 'background',
  keymode: 'none',
  visible: true,
  anchor: ['top', 'left'],
  layer: 'background',
  child: Background(),
});
