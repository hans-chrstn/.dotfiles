import Icon from 'lib/Icons';
const { wifi, toggleWifi } = await Service.import('network');

function toDbm(percent) {
  return 0.7 * percent - 100;
}

export default () => Widget.Box({
  vertical: true,
  cssClasses: ['bnetwork-box'],
  children: [
    Widget.Box({
      vertical: false,
      children: [
        Widget.Button({
          on_clicked: () => toggleWifi(),
          child: Widget.Label({
            cssClasses: ['bnetwork-icon'],
            setup: self => {
              self.hook(wifi, (self) => {
                self.label = wifi.internet === 'connected' ?
                  wifi.strength < 30 ? Icon.wifi.weak :
                  wifi.strength < 60 ? Icon.wifi.average :
                  wifi.strength < 80 ? Icon.wifi.good :
                  Icon.wifi.great : Icon.wifi.disabled;
              })
            }
          }),
        }),
        Widget.Button({
          on_clicked: () => App.toggleWindow('wifi-menu'),
          child: Widget.Label({
            cssClasses: ['bnetwork-internet'],
            label: 'INTERNET',
          })
        }),
      ],
    }),
    Widget.Box({
      vertical: false,
      child: Widget.Label({
        cssClasses: ['bnetwork-ssid'],
        label: wifi.bind('ssid').transform(s => `${s}` || '...'),
      }),
    }),
    Widget.Box({
      vertical: false,
      child: Widget.Label({
        cssClasses: ['bnetwork-speed'],
        setup: self => {
          self.hook(wifi, (self) => {
            self.label = `SPEED: ${toDbm(wifi.strength).toFixed(1)} dBm`
          })
        },
      })
    })
  ],
});


