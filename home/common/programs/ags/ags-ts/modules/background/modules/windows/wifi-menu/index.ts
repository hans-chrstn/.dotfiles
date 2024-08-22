import { Network } from 'imports';
import Icons from 'lib/icons';

const WifiMenu = () => Widget.Box({
  className: 'wifi-menu',
  vertical: true,
  children: [
    Widget.CenterBox({
      startWidget: Widget.Label({
        hpack: 'start',
        label: 'Network',
        className: 'wifi-menu-title',
      }),
      endWidget: Widget.Button({
        hpack: 'end',
        className: 'wifi-menu-close',
        on_clicked: () => App.closeWindow('wifi-menu'),
        child: Widget.Label(Icons.power.powerbutton),
      }),
    }),
    Widget.Scrollable({
      vscroll: 'always',
      hscroll: 'never',
      vexpand: true,
      className: 'wifi-menu-scrollable',
      child: Widget.Box({
        className: 'wifi-menu-scrollable-box',
        vertical: true,
        spacing: 20,
        setup: self => {
          self.hook(Network, (self) => {
            self.children = Network.wifi?.access_points.map(ap => Widget.Button({
              on_clicked: () => Utils.execAsync(`nmcli device wifi connect ${ap.bssid}`),
              child: Widget.CenterBox({
                startWidget: Widget.Box({
                  spacing: 20,
                  children: [
                    Widget.Icon({
                      icon: ap.iconName,
                      className: 'wifi-menu-icon',
                      size: 18,
                    }),
                    Widget.Label({
                      label: ap.ssid,
                      className: 'wifi-menu-ssid',
                      maxWidthChars: 20,
                    }),
                  ],
                }),
                endWidget: Widget.Label({
                  label: `${ap.active ? '' : Icons.location.arrow}`,
                  hpack: 'end',
                  className: 'wifi-menu-check',
                }),
              }),
            }))
          })
        }
      }),
    }),
  ],
});

export default () => Widget.Window({
  name: 'wifi-menu',
  visible: false,
  keymode: 'on-demand',
  anchor: ['top', 'left'],
  layer: 'top',
  child: WifiMenu(),
  setup: self => self.keybind('Escape', () => {
    App.closeWindow('wifi-menu');
  }),
});
