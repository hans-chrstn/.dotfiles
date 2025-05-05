import { App } from "astal/gtk3"
import style from "../style.scss"
import Background from "../src/components/background"
import { monitorStyles, reloadCss } from "../src/utils/styles"
import Settings from "../src/components/settings"
import Notch from "../src/components/notch"

export default () => {
    App.start({
        css: style,
        async main() {
            // reloads css on startup
            await reloadCss();
            Background(0);
            Background(1);
            Notch(0);
            Settings(0)
            monitorStyles();
        },
    });
};


