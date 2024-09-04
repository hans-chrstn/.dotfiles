import Gio from "gi://Gio"
import Circle from "modules/circle/index";
import { forMonitors } from "lib/utils";

async function reloadCss() {
  Utils.exec(`sassc ${App.configDir}/styles/main.scss ${App.configDir}/style.css`);
  App.resetCss();
  App.applyCss(`${App.configDir}/style.css`);
  console.log('[LOG] SCSS and Styles applied')
}

Utils.monitorFile(
  `${App.configDir}/styles/`, (_, eventType) => {
    if(eventType === Gio.FileMonitorEvent.CHANGES_DONE_HINT) {
      reloadCss();
    }
  }
)

reloadCss();

function addWindows(windows) {
  windows.forEach(win => App.addWindow(win));
}

Utils.idle(() => addWindows([
  ...forMonitors(Circle),
]));

App.config({
  style: `${App.configDir}/style.css`,
  closeWindowDelay: {

  },
});
