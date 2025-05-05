import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { bind } from "astal"
import { date, meridiem } from "../../utils/time"
import { CavaWidget } from "../../utils/cairo";
import { Weather } from "../../services/weather";

// const weather = Weather.get_default();

export default function Background(monitor: number) {
    return <window
        name={`Background-${monitor}`}
        className="Background"
        monitor={monitor}
        exclusivity={Astal.Exclusivity.IGNORE}
        layer={Astal.Layer.BOTTOM}
        anchor={Astal.WindowAnchor.NONE}
        application={App}
    >
        <box className={'background-container'} orientation={Gtk.Orientation.VERTICAL}>
            <box className={'background-temp-container'} orientation={Gtk.Orientation.HORIZONTAL}>
                {[
                    // <label className={'background-temp-temp'} label={bind(weather, "temp")} />
                ]}
            </box>
            <box className={'background-date-container'} orientation={Gtk.Orientation.HORIZONTAL}>
                {[
                    <label className={'background-date-date'} label={bind(date(1000)).as((date) => date.format('%A %-d %B') || '')}/>
                ]}
            </box>
            <box className={'background-time-container'} orientation={Gtk.Orientation.HORIZONTAL}>
                {[
                    <label className={'background-time-time'} label={bind(date(1000)).as((time) => time.format('%H %M') || '')}/>
                ]}
            </box>
            <box className={'background-time-container'} orientation={Gtk.Orientation.HORIZONTAL}>
                {[
                    <label className={'background-time-meridiem'} label={bind(meridiem())}/>
                ]}
            </box>
                <CavaWidget sizeX={50} sizeY={50} className="background-cava"/>
        </box>
    </window>
}
