import { App } from 'astal/gtk3';
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
import { exec } from "astal"

// switch (programArgs[0]) {
//     case 'mishima': mishima(); break;
// }
//
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
