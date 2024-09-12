import { Bluetooth } from "imports";
import icons from "lib/icons";

export default () => {
  const BluetoothMenu = Widget.Box({
    vertical: true,
    className: 'bluetooth-menu',
    children: [
      Widget.CenterBox({
        startWidget: Widget.Button({
          hpack: 'start',
          onClicked: () => {
            Bluetooth.toggle()
            if (Bluetooth.enable === true)
              Utils.exec('bluetoothctl scan on')
            else Utils.exec('bluetoothctl scan off')
          },
          label: Bluetooth.bind('enabled').transform(b => b ? icons.bluetooth.enabled : icons.bluetooth.disabled),
        }),
        endWidget: Widget.Button({
          hpack: 'end',
          onClicked: () => App.closeWindow('bluetooth-menu'),
          label: icons.power.powerbutton,
        }),
      }),
      Widget.Scrollable({
        className: 'bluetooth-menu-scroll',
        vscroll: 'always',
        hscroll: 'never',
        child: Widget.Box({
          vertical: true,
          spacing: 20,
          className: 'bluetooth-menu-scroll-box',
          setup: self => {
            self.hook(Bluetooth, () => {
              self.children = Bluetooth.devices.map(d => Widget.Button({
                onClicked: () => {
                  Utils.exec(`bluetoothctl pair ${d.address}`)
                  Utils.timeout(2000, () => {
                    Utils.exec(`bluetoothctl connect ${d.address}`)
                  })
                },
                child: Widget.CenterBox({
                  startWidget: Widget.Box({
                    children: [
                      Widget.Icon({
                        className: 'bluetooth-menu-scroll-box-name',
                        icon: d.icon_name? d.icon_name : '',
                        size: 12,
                      }),
                      Widget.Label({
                        label: d.name? d.name : d.address,
                      }),
                    ],
                  }),
                  endWidget: Widget.Label({
                    hpack: 'end',
                    label: !d.connected ? '' : icons.location.arrow,
                    css: 'margin-right: 8px;',
                  })
                })
              })) 
            })
          }  
        })
      }),
    ],
  })

  return Widget.Window({
    name: 'bluetooth-menu',
    keymode: 'on-demand',
    layer: 'top',
    visible: false,
    child: Widget.Box({
      children: [
        BluetoothMenu,
      ],
    }),
  })
}
