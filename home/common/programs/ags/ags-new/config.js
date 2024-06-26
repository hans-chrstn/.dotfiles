import Bar from './modules/bar/Bar.js';
import PowerMenu from './modules/bar/window/PowerMenu.js';
import { Utils, App } from './utils/imports.js';
import Gio from 'gi://Gio';
import BackgroundWidget from './modules/background/BackgroundWidget.js';
import AppLauncher from './modules/launcher/Launcher.js';
import WifiMenu from './modules/background/windows/WifiMenu.js';
import PowerMenuVerify from './modules/bar/window/PowerMenuVerify.js';

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
  Bar(1),
  BackgroundWidget(1),
  AppLauncher(),
  PowerMenu(),
  WifiMenu(),
  PowerMenuVerify(),
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
