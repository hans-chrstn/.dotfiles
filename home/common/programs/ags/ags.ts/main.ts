import Gio from 'gi://Gio';
import { forMonitors } from 'lib/utils';
import Bar from 'modules/bar/index';

const scss = `${App.configDir}/styles/main.scss`;
const css = `${App.configDir}/style.css`;
const icons = `${App.configDir}/lib/icons.ts`;

async function reloadCss() {
  Utils.exec(`sassc ${scss} ${css}]`);
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
]));

App.config({
  style: css,
  icons: icons,
  closeWindowDelay: {
    'bar-0': 500, // MS
    'bar-1': 500,
  },
})
