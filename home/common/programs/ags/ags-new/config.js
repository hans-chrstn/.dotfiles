import { Utils, App } from './lib/Imports.js';
import Gio from 'gi://Gio';
import { forMonitors } from './lib/Utils.js';
import Bar from './modules/bar/Bar.js';
import BackgroundWidget from './modules/background/BackgroundWidget.js';
import PowerMenu from './modules/bar/modules/windows/PowerMenu.js';
import PowerMenuVerify from './modules/bar/modules/windows/PowerMenuVerify.js';
import WifiMenu from './modules/background/modules/windows/WifiMenu.js';
import AppLauncher from './modules/launcher/Launcher.js';
import Greetd from './modules/greetd/Greetd.js';
import BluetoothMenu from './modules/bar/modules/Bluetooth.js';

const scss = `${App.configDir}/scss/main.scss`;
const css = `${App.configDir}/style.css`;
const icons = `${App.configDir}/modules/icons`;

async function applyStyle() {
  Utils.exec(`sass ${scss} ${css}`);
  console.log('[LOG] SCSS Applied');
  App.resetCss();
  App.applyCss(css);
  console.log('[LOG] Styles Loaded');
}

Utils.monitorFile(
  `${App.configDir}/scss/`, (_, eventType) => {
    if(eventType === Gio.FileMonitorEvent.CHANGES_DONE_HINT) {
      applyStyle();
    }
  }
);

applyStyle();

/**
 * @param {import('types/@girs/gtk-3.0/gtk-3.0').Gtk.Window[]} windows
 */
function addWindows(windows) {
  windows.forEach(win => App.addWindow(win));
}

Utils.idle(() => addWindows([
  ...forMonitors(Bar),
  ...forMonitors(BackgroundWidget),
  AppLauncher(),
  PowerMenu(),
  WifiMenu(),
  PowerMenuVerify(),
  Greetd(),
  BluetoothMenu(),
]));

App.config({
  style: css,
  icons: icons,
  closeWindowDelay: {
       
    'bar0': 500, // milliseconds
    'bar1': 500,
        
  },
  onConfigParsed: function() {
        /* code that runs after this object is loaded */
  },
    /* 
    onWindowToggled: function(windowName, visible) {
        print(`${windowName} is ${visible} `)
    },
    */
    
  notificationPopupTimeout: 5000,
  notificationForceTimeout: true,
  cacheCoverArt: true,
    /* cacheNotificationActions: boolean; */
    /* maxStreamVolume: number; */
});
