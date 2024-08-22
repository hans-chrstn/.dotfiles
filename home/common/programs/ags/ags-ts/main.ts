import Gio from 'gi://Gio';
import { forMonitors } from 'lib/utils';
import Bar from 'modules/bar/index';
import PowerMenu from 'modules/bar/modules/windows/powermenu/index';
import PowerMenuVerify from 'modules/bar/modules/windows/powermenu/verify';
import Background from 'modules/background/index';
import WifiMenu from 'modules/background/modules/windows/wifi-menu/index';
import Launcher from 'modules/launcher/index';

async function reloadCss() {
  Utils.exec(`sassc ${App.configDir}/styles/main.scss ${App.configDir}/style.css`);
  App.resetCss();
  App.applyCss(`${App.configDir}/style.css`);
  console.log('[LOG] SCSS and Styles applied');
}

Utils.monitorFile(
  `${App.configDir}/styles/`, (_, eventType) => {
    if(eventType === Gio.FileMonitorEvent.CHANGES_DONE_HINT) {
      reloadCss();
    }
  }
);

reloadCss();

function addWindows(windows) {
  windows.forEach(win => App.addWindow(win));
}

Utils.idle(() => addWindows([
  ...forMonitors(Bar), 
  ...forMonitors(Background),
  PowerMenu(),
  PowerMenuVerify(),
  WifiMenu(),
  Launcher(),
]));

App.config({
  style: `${App.configDir}/style.css`,
  icons: `${App.configDir}/modules/Icons/Index`,
  closeWindowDelay: {
    'bar0': 500, // MS
    'bar1': 500,
  },
})
