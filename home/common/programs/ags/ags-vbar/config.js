import VBar from './VBar.js';
import { Utils, App } from './utils/imports.js';
import Gio from 'gi://Gio';

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
    });

applyStyle();

/**
 * @param {import('types/@girs/gtk-3.0/gtk-3.0').Gtk.Window[]} windows
 */
function addWindows(windows) {
    windows.forEach(win => App.addWindow(win));
}

Utils.idle(() => addWindows([
    VBar(1),
//    Bar(1),
]));

App.config({
    style: css,
    icons: icons,
    closeWindowDelay: {
         
        'vbar0': 1000, // milliseconds
        
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
