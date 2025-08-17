import { App } from "astal/gtk3"
import style from "../style.scss"
import Background from "../src/components/background"
import { monitorStyles, reloadCss } from "../src/utils/styles"
import Settings from "../src/components/settings"
import Notch from "../src/components/notch"
import { forMonitors } from "../src/utils/monitors"
import OSD from "../src/components/popups"
import { exec } from "astal"

export default () => {
    App.start({
        css: style,
        async main() {
            // reloads css on startup
            await reloadCss();
            forMonitors(Background);
            forMonitors(Notch);
            Settings(0)
            forMonitors(OSD)
            monitorStyles();

            // fixes animation issues with the Notch when using Hyprland
            exec('hyprctl keyword layerrule noanim,Notch')
        },
    });
};


