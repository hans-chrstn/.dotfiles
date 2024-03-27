import Bar from './bar.js';
import { Utils, App } from './utils/imports.js';
/* dir var */
const scss = `${App.configDir}/scss/main.scss`;
const css = `${App.configDir}/style.css`;
const icons = `${App.configDir}/assets/icons`;

/* scss applies to css */
async function applyStyle() {
    Utils.exec(`sass ${scss} ${css}`)
    App.resetCss();
    App.applyCss(css);
    console.log('[LOG] Styles loaded')

}
applyStyle().catch(print);

/* auto-reloads css when main.scss changes */
Utils.monitorFile(
    `${App.configDir}/scss/`,
    function() {
        applyStyle()
    },
    'directory',
)

/**
 * @param {import('types/@girs/gtk-3.0/gtk-3.0').Gtk.Window[]} windows
 */
function addWindows(windows) {
    windows.forEach(win => App.addWindow(win));
}

Utils.idle(() => addWindows([
    Bar(1),
]));

/* load */
App.config({
    style: css,
    icons: icons,
    closeWindowDelay: {
        /* 
        "window-name": 500, // milliseconds
        */
    },
    onConfigParsed: function() {
        /* code that runs after this object is loaded */
    },
    /* 
    onWindowToggled: function(windowName, visible) {
        print(`${windowName} is ${visible} `)
    },
    */
    
    /* notificationPopupTimeout: number; */
    /* notificationForceTimeout: boolean; */
    /* cacheNotificationActions: boolean; */
    /* cacheCoverArt: boolean; */
    /* maxStreamVolume: number; */
})
