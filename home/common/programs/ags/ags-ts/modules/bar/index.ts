import Clock from './modules/clock';
import Power from './modules/power';
const Left = () => Widget.Box({
  className: 'bar-left',
  homogeneous: false,
  vertical: false,
  hpack: 'start',
  children: [],
});

const Center = () => Widget.Box({
  className: 'bar-center',
  homogeneous: false,
  vertical: false,
  hpack: 'center',
  children: [
    Clock(),
  ],
});

const Right = () => Widget.Box({
  className: 'bar-right',
  homogeneous: false,
  vertical: false,
  hpack: 'end',
  children: [
    Power(),
  ],
});

export default (monitor: number) => Widget.Window({
  name: `bar${monitor}`,
  monitor,
  anchor: ['top', 'right', 'left'],
  exclusivity: 'exclusive',
  child: Widget.CenterBox({
    className: 'bar-layout',
    startWidget: Left(),
    centerWidget: Center(),
    endWidget: Right(),
  })

});
