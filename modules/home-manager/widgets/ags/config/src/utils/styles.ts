import { exec, Gio, monitorFile } from "astal";
import { App } from "astal/gtk3";

export async function reloadCss() {
  try {
      exec(`sassc ./src/styles/main.scss /tmp/style.css`)
      App.reset_css();
      App.apply_css(`/tmp/style.css`);
      console.log('[LOG] SCSS and Styles applied!');
  } catch (err) {
      console.log(err);
  }

}

export function monitorStyles() {
    monitorFile(`./src/styles/`, async (loc, eventType) => {
      if(eventType === Gio.FileMonitorEvent.CHANGES_DONE_HINT) {
          await reloadCss();
          console.log(`Changes done at ${loc}`)
      }
  })
}
