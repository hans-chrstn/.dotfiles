import Profile from './modules/profile';
import Calendar from './modules/calendar';
import Clock from './modules/clock';
import FileDir from './modules/files';
import Uptime from './modules/uptime';
import icons from 'lib/icons';

const sideButtons = (click: string, text: string, cname: string = 'powermenu-launcher') => Widget.Box({
  vertical: true,
  vpack: 'start',
  className: cname,
  child: Widget.Button({
    onClicked: () => {
      App.toggleWindow(click)
    },
    child: Widget.Label({
      label: text,
    }),
  })
})

const Side = () => Widget.Box({
  vertical: true,
  vpack: 'start',
  hexpand: false,
  children: [
    sideButtons('applauncher', icons.power.powerbutton),
    sideButtons('bluetooth-menu', icons.bluetooth.enabled),
  ],
})
const Left = () => Widget.Box({
  vertical: true,
  vpack: 'start',
  hexpand: false,
  vexpand: false,
  children: [
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
  anchor: [],
  exclusivity: 'normal',
  keymode: 'on-demand',
  layer: 'top',
  setup: self => self.keybind('Escape', () => {
    App.closeWindow('powermenu');
  }),
  child: Widget.Box({
    className: 'powermenu',
    children: [
      Side(),
      Left(),
      Center(),
      Right(),
    ],
  }),
});
