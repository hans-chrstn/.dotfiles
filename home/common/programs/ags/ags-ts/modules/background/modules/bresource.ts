import { Battery } from 'imports';

const CircResource = () => Widget.Box({
  vertical: false,
  className: 'bresource-circ-box',
  children: [
    Widget.Overlay({
      overlay: Widget.CircularProgress({
        visible: Battery.bind('available'),
        value: Battery.bind('percent').as(p => p > 0 ? p / 100 : 0),
        start_at: 0.75,
        inverted: true,
        className: 'bresource-circ-battery-outer',
        child: Widget.Button({
          on_clicked: () => Utils.execAsync(['kitty', '-e', 'btop']),
          child: Widget.Icon({ icon: Battery.icon_name, size: 14,})
        }),
      }),
      child: Widget.CircularProgress({
        visible: true,
        value: 1.0,
        className: 'bresource-circ-battery-inner',
      }),
    }),
  ],
});

const ResourceLabels = () => Widget.Box({
  vertical: false,
  className: 'bresource-label',
  children: [
    Widget.Label({
      className: 'bresource-label-battery',
      setup: self => {
        self.hook(Battery, (self) => {
          self.label = Battery.percent + '%' || '...';
        })
      },
    }),
  ],
});

export default () => Widget.Box({
  vertical: true,
  className: 'bresource',
  hpack: 'start',
  children: [
    CircResource(),
    ResourceLabels(),
  ],
})
