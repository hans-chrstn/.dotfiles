import Profile from './modules/profile';
import Calendar from './modules/calendar';
import Clock from './modules/clock';
import FileDir from './modules/files';
import Uptime from './modules/uptime';
import Power from './modules/power';
import icons from 'lib/icons';

const sideButtons = (click: string, text: string) => Widget.Box({
  vertical: true,
  className: 'powermenu-launcher',
  child: Widget.Button({
    onClicked: () => {
      App.toggleWindow(click)
    },
    child: Widget.Label({
      label: text,
      css: 'margin-right: 1px;'
    }),
  })
})

const Side = () => Widget.Box({
  vertical: true,
  vpack: 'start',
  hexpand: false,
  children: [
    sideButtons('applauncher', icons.apps),
    sideButtons('bluetooth-menu', icons.bluetooth.enabled),
  ],
})
const Left = () => Widget.Box({
  vertical: true,
  vpack: 'start',
  hexpand: false,
  vexpand: false,
  children: [
    Power(),
  ],
});

const Center = () => Widget.Box({
  vertical: true,
  vpack: 'start',
  hexpand: false,
  vexpand: false,
  children: [
    Clock(),
    FileDir(),
    Uptime(),
  ],
});

const Right = () => Widget.Box({
  vertical: true,
  vpack: 'start',
  hexpand: false,
  vexpand: false,
  children: [
    Profile(),
    Calendar(),
  ],
});

export default () => Widget.Window({
  name: `powermenu`,
  visible: false,
  anchor: ['top', 'bottom', 'left', 'right'],
  exclusivity: 'normal',
  keymode: 'on-demand',
  layer: 'top',
  setup: self => self.keybind('Escape', () => {
    App.closeWindow('powermenu');
  }),
  child: Widget.Box({
    vpack: 'center',
    hpack: 'center',
    children: [
      Side(),
      Left(),
      Center(),
      Right(),
    ],
  }),
});
