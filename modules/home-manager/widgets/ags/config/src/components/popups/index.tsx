import { Variable } from "astal";
import { App, Astal, Gdk } from "astal/gtk3";
import { OnScreenProgess } from "./onScreenDisplay";

export default function OSD(monitor: number) {
    const visible = Variable(false)

    const event = <eventbox
        onClick={() => visible.set(false)}
        child={<OnScreenProgess visible={visible}/>}
    />

    return (
        <window
            monitor={monitor}
            className={'OSD'}
            namespace={'osd'}
            application={App}
            layer={Astal.Layer.OVERLAY}
            keymode={Astal.Keymode.ON_DEMAND}
            anchor={Astal.WindowAnchor.BOTTOM}
            child={event}
        />
    )
}
