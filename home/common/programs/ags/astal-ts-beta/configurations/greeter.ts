import { App } from "astal/gtk3"
import style from "../src/styles/greeter.scss";
import Lockscreen from "../src/components/lock";
import { subprocess } from "astal";

export default () => {
    App.start({
        css: style,
        instanceName: 'greeter',
        main: () => {
            Lockscreen(0);
        }
    })
}
