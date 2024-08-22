import BDate from './modules/bdate';
import BWeather from './modules/bweather';
import BNetwork from './modules/bnetwork';
import BResource from './modules/bresource';
const Background = () => Widget.Box({
  vertical: true,
  spacing: 15,
  children: [
    Widget.Box({
      vertical: false,
      children: [
        BDate(),
      ],
    }),
    Widget.Box({
      vertical: false,
      children: [
        BWeather(),
        BNetwork(),
      ],
    }),
    Widget.Box({
      vertical: false,
      children: [
        BResource(),
      ],
    }),
  ],
})

export default (monitor: number) => Widget.Window({
  name: `background${monitor}`,
  monitor,
  visible: true,
  keymode: 'none',
  anchor: ['top', 'left'],
  layer: 'background',
  child: Background(),
})
