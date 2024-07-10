import { Widget, Bluetooth } from '../../../lib/Imports.js';
import Icon from '../../icons/Icons.js';

const BItems = device => Widget.Box({
  spacing: 20,
  children: [
    Widget.Label({ label: Icon.bluetooth.enabled, class_name: 'bluetoothmenu_items_icon'}),
    Widget.Label(device.name),
    Widget.Label({
      label: `${device.battery_percentage}%`,
      class_name: 'bluetoothmenu_items_battery',
      visible: device.bind('battery_percentage').transform(bp => bp > 0),
    }),
    Widget.Box({ hexpand: true }),
    Widget.Spinner({
      active: device.bind('connecting'),
      visible: device.bind('connecting'),
    }),
    Widget.Switch({
      active: device.connected,
      visible: device.bind('connecting').transform(p => !p),
      setup: self => self.on('notify::active', () => {
        device.setConnection(self.active);
      })
    })
  ],
});

const BluetoothMenu = () => Widget.Box({
  class_name: 'bluetoothmenu_box',
  vertical: true,
  children: [
    Widget.CenterBox({
      start_widget: Widget.Label({
        hpack: 'start',
        label: 'Bluetooth',
        class_name: 'bluetoothmenu_label',
      }),
      end_widget: Widget.Button({
        hpack: 'end',
        label: Icon.power.powerbutton,
        class_name: 'bluetoothmenu_exit',
        on_clicked: () => App.closeWindow('bluetooth_menu'),
      }),
    }),
    Widget.Scrollable({
      vscroll: 'always',
      hscroll: 'never',
      vexpand: true,
      class_name: 'bluetoothmenu_scrollable',
      child: Widget.Box({
        class_name: 'bluetooth_scrollable_box',
        vertical: true,
        spacing: 20,
        setup: (self) => {
          self.hook(Bluetooth, (self) => {
            const devices = Bluetooth.bind('devices').transform(ds => ds.filter(d => d.name))
            self.children = devices["emitter"]["devices"].map(BItems)
          })
        }
      })

    }),
  ],
})

export default () => Widget.Window({
  name: 'bluetooth_menu',
  visible: false,
  child: BluetoothMenu(),
})
