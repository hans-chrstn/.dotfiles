export default (monitor: number) => Widget.Window({
  name: `circle-${monitor}`,
  monitor,
  exclusivity: 'normal',
  layer: "background",
  child: Widget.Box({
    children: [
      Widget.CircularProgress({
        visible: true,
        value: 1.0,
        className: 'circle',
      }),
    ],
  }),
});
