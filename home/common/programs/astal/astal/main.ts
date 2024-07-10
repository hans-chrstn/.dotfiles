import Bar from 'modules/bar/Index';
import PowerMenu from 'modules/bar/modules/windows/PowerMenu/Index';
import PowerMenuVerify from 'modules/bar/modules/windows/PowerMenu/Verify';
import Background from 'modules/background/Index';
import WifiMenu from 'modules/background/modules/windows/WifiMenu';
import Launcher from 'modules/launcher/Launcher';
import { forMonitors } from 'lib/Utils';
import Gio from 'types/@girs/gio-2.0/gio-2.0';

const css = `${App.configDir}/style.css`;
const icons = `${App.configDir}/modules/Icons/Index.ts`;

async function reloadCss() {
	Utils.exec(`sassc ${App.configDir}/scss/main.scss ${App.configDir}/style.css`);
	App.resetCss();
	App.applyCss(`${App.configDir}/style.css`);
  console.log('[LOG] SCSS and Styles Applied')
}

Utils.monitorFile(
  `${App.configDir}/scss/`, (_, eventType) => {
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
  PowerMenu(),
  PowerMenuVerify(),
  Background(),
  WifiMenu(),
  Launcher(),
]));

App.config({
  style: css,
  icons: icons,
  closeWindowDelay: {
       
    'bar0': 500, // MS
    'bar1': 500,
        
  },
})
