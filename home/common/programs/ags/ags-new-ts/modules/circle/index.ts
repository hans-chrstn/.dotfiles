export default (monitor: number) => Widget.Window({
  name: `circle-${monitor}`,
  monitor,
  anchor: ['right', 'left'],
  exclusivity: 'normal',
  layer: "background",
  child: Widget.CircularProgress({
    visible: true,
    value: 1.0,
    className: 'circle',
  }),
});
