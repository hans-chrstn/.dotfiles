import Icon from 'lib/Icons';
const { wifi } = await Service.import('network');

const WifiMenu = () => Widget.Box({
  cssClasses: ['wifi-menu-box'],
  vertical: true,
  children: [
    Widget.CenterBox({
      startWidget: Widget.Label({
        hpack: 'start',
        label: 'Network',
        cssClasses: ['wifi-menu-title'],
      }),
      endWidget: Widget.Button({
        hpack: 'end',
        cssClasses: ['wifi-menu-close'],
        on_clicked: () => App.closeWindow('wifi-menu'),
        child: Widget.Label(Icon.power.powerbutton),
      }),
    }),
    Widget.Scrollable({
      vscroll: 'always',
      hscroll: 'never',
      vexpand: true,
      cssClasses: ['wifi-menu-scrollable'],
      child: Widget.Box({
        cssClasses: ['wifi-menu-scrollable-box'],
        vertical: true,
        spacing: 20,
        setup: self => {
          self.hook(wifi, (self) => {
            self.children = wifi?.access_points.map(ap => Widget.Button({
              on_clicked: () => Utils.execAsync(`nmcli device wifi connect ${ap.bssid}`),
              child: Widget.CenterBox({
                startWidget: Widget.Box({
                  spacing: 20,
                  children: [
                    Widget.Icon({ icon: ap.iconName, cssClasses: ['wifi-menu-icon']}),
                    Widget.Label({
                      label: ap.ssid,
                      cssClasses: ['wifi-menu-ssid'],
                      maxWidthChars: 20,
                    })
                  ],
                }),
                endWidget: Widget.Label({
                  label: `${ap.active ? '' : Icon.location.arrow}`,
                  hpack: 'end',
                  cssClasses: ['wifi-menu-check'],
                }),
              })
            }))
          })
        }
      }),
    })
  ],
})

export default () => Widget.Window({
  name: 'wifi-menu',
  visible: false,
  keymode: 'on-demand',
  anchor: ['top', 'left'],
  layer: 'top',
  child: WifiMenu(),
})
