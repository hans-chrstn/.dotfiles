import { Widget, App, Network, Utils } from '../../../utils/imports.js';
import Icons from '../../icons/Icons.js';

const WifiMenu = () => Widget.Box({
  class_name: 'wifimenu_box',
  vertical: true,
  children: [
    Widget.CenterBox({
      start_widget: Widget.Label({
        hpack: 'start',
        label: 'Network',
        class_name: 'wifimenu_title',
      }),
      end_widget: Widget.Button({
        hpack: 'end',
        label: Icons.power.powerbutton,
        class_name: 'wifimenu_close',
        on_clicked: () => App.closeWindow('wifimenu')
      }),
    }),
    Widget.Scrollable({
      vscroll: 'always',
      hscroll: 'never',
      vexpand: true,
      class_name: 'wifimenu_scrollable',
      child: Widget.Box({
        class_name: 'wifimenu_scrollable_box',
        vertical: true,
        spacing: 20,
        setup: self => {
          self.hook(Network, (self) => {
            self.children = Network.wifi?.access_points.map(ap => Widget.Button({
              on_clicked: () => Utils.execAsync(`nmcli device wifi connect ${ap.bssid}`),
              child: Widget.CenterBox({
                start_widget: Widget.Box({
                  spacing: 20,
                  children: [
                    Widget.Icon({ icon: ap.iconName, size: 18 }),
                    Widget.Label({
                      label: ap.ssid,
                      class_name: 'wifimenu_ssid',
                      maxWidthChars: 24,
                    }),
                  ],
                }),
                end_widget: Widget.Label({
                  label: `${ap.active ? '' : '󰄬'}`,
                  hpack: 'end',
                  class_name: 'wifimenu_check',
                }),
              }),
            }));
          });
        },
      }),
    }),
  ],
});

export default () => Widget.Window({
  name: 'wifimenu',
  visible: 'false',
  keymode: 'on-demand',
  anchor: ['top', 'left'],
  layer: 'top',
  child: WifiMenu()
})
