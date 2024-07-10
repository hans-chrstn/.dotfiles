import Clock from './modules/Clock.ts';
import Power from './modules/Power.ts';

const Left = () =>
  Widget.Box({
    cssClasses: ["bar-left"],
    homogeneous: false,
    vertical: false,
    hpack: "start",
    children: [],
  });

const Center = () =>
  Widget.Box({
    cssClasses: ["bar-center"],
    homogeneous: false,
    vertical: false,
    hpack: "center",
    children: [Clock()],
  });

const Right = () =>
  Widget.Box({
    cssClasses: ["bar-right"],
    homogeneous: false,
    vertical: false,
    hpack: "end",
    children: [
      Power(),
    ],
  });

export default (monitor: number) =>
  Widget.Window({
    name: `bar${monitor}`,
    monitor,
    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
      cssClasses: ["bar-layout"],
      startWidget: Left(),
      centerWidget: Center(),
      endWidget: Right(),
    }),
  });
