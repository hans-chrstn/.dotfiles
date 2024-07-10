import { App, Network, Widget } from '../../../lib/Imports.js';
import Icons from '../../icons/Icons.js';

function convertToDbm(percentage) {
  return 0.7 * percentage - 100;
}

export default () => Widget.Box({
  vertical: true,
  class_name: 'network_box',
  children: [
    Widget.Box({
      vertical: false,
      children: [
        Widget.Button({
          on_primary_click: () => {
            Network.toggleWifi()
          },
          child: Widget.Label({
            class_name: 'network_icon',
            setup: self => {
              self.hook(Network, (self) => {
                self.label = Network.wifi.internet === 'connected' ?
                  Network.wifi.strength < 30 ? Icons.wifi.weak :
                  Network.wifi.strength < 60 ? Icons.wifi.average :
                  Network.wifi.strength < 80 ? Icons.wifi.good :
                  Icons.wifi.great : Icons.wifi.disabled;
              });
            },
          }),
        }),
        Widget.Button({
          on_primary_click: () => App.toggleWindow('wifimenu'),
          child: Widget.Label({
            class_name: 'network_internet',
            label: 'INTERNET',
          }),
        }),
      ],
    }),

    Widget.Box({
      vertical: false,
      child: Widget.Label({
        class_name: 'network_name',
        label: Network.wifi.bind('ssid'),
      }),
    }),

    Widget.Box({
      vertical: false,
      child: Widget.Label({
        class_name: 'network_speed',
        setup: self => {
          self.hook(Network, (self) =>{
            self.label = `SPEED: ${convertToDbm(Network.wifi.strength).toFixed(1)} dBm`
          });
        },
      }),
    }),
  ],
});
