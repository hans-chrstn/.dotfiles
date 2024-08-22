import Icons from 'lib/icons';
import { Network } from 'imports';

function toDbm(percent) {
  return 0.7 * percent - 100;
}

const Internet = () => Widget.Box({
  vertical: false,
  children: [
    Widget.Button({
      on_clicked: () => Network.toggleWifi(),
      child: Widget.Label({
        className: 'bnetwork-icon',
        setup: self => {
          self.hook(Network, (self) => {
            self.label = Network.wifi.internet === 'connected' ?
              Network.wifi.strength <= 30 ? Icons.wifi.weak :
              Network.wifi.strength <= 60 && Network.wifi.strength > 30 ? Icons.wifi.average :
              Network.wifi.strength <= 80 && Network.wifi.strength > 60 ? Icons.wifi.good :
              Icons.wifi.great : Icons.wifi.disabled;
          })
        },
      }),
    }),
    Widget.Button({
      on_clicked: () => App.toggleWindow('wifi-menu'),
      child: Widget.Label({
        className: 'bnetwork-internet',
        label: 'INTERNET',
      }),
    }),
  ],
});

const SSID = () => Widget.Box({
  vertical: false,
  child: Widget.Label({
    className: 'bnetwork-ssid',
    label: Network.wifi.bind('ssid').transform(s => s || '...'),
  }),
});

const Speed = () => Widget.Box({
  vertical: false,
  child: Widget.Label({
    className: 'bnetwork-speed',
    setup: self => {
      self.hook(Network, (self) => {
        self.label = `SPEED: ${toDbm(Network.wifi.strength).toFixed(1)} dBm`;
      })
    }
  }),
})

const Type = () => Widget.Box({
  vertical: false,
  child: Widget.Label({
    className: 'bnetwork-type',
    setup: self => {
      self.hook(Network, (self) => {
        self.label = `${Network.primary}  ${Icons.wifi.access_point[Network.primary]}`;
      })
    },
  }),
});

export default () => Widget.Box({
  vertical: true,
  className: 'bnetwork',
  hpack: 'end',
  children: [
    Internet(),
    SSID(),
    Speed(),
    Type(),
  ],
});
