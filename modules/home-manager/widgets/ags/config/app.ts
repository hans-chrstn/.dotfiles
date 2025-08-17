import app from 'ags/gtk4/app';
import style from './style.scss';
import Background from './src/components/background';
import { monitorStyles, reloadCss } from './src/utils/styles';
import { forMonitors } from './src/utils/monitors';
import Settings from './src/components/settings';
import Notch from './src/components/notch';
import Lockscreen from './src/components/lock';
import { programArgs } from 'system';
import mishima from './configurations/mishima';
import OSD from "./src/components/popups";
import { exec } from "ags/process"

// switch (programArgs[0]) {
//     case 'mishima': mishima(); break;
// }
//
app.start({
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
