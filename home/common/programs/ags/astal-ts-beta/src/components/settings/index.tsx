import { exec, GLib} from "astal";
import { App, Astal, Gtk } from "astal/gtk3"
import { FileChooserButton } from "../lib/fileChooserButton";
import { MoveableWindow } from "../lib/moveableWindow";

let wallpaper_path = `${GLib.get_current_dir()}/assets/wallpaper`;
let name: string = "Settings";

function Wallpaper(): JSX.Element {
    const file = <FileChooserButton
        className={"settings-wallpaper-inner-filechooser"}
        onFileSet={(self) => {
            const file = self.get_filename();
            console.log(wallpaper_path);
            if (GLib.file_test(wallpaper_path, GLib.FileTest.IS_SYMLINK)) {
                GLib.unlink(wallpaper_path)
            }
            exec(`ln -sf "${file}" "${wallpaper_path}"`)
        }}
    />

    const preview = <box className={"settings-wallpaper-inner-preview-container"}>
        <box className={"settings-wallpaper-inner-preview"}/>
    </box>

    return (<box className={"settings-wallpaper-inner"} orientation={Gtk.Orientation.VERTICAL}>
        {preview}
        {file}
        <button label={"Apply"} onClick={(_) => {
            exec(`hyprctl hyprpaper reload ,"${wallpaper_path}"`);
        }}/>
    </box>)
}

export default function Settings(monitor: number) {
    return <MoveableWindow
        name={`${name}-${monitor}`}
        className={name}
        monitor={monitor}
        exclusivity={Astal.Exclusivity.IGNORE}
        layer={Astal.Layer.TOP}
        anchor={Astal.WindowAnchor.NONE}
        application={App}
        widthRequest={400}
        heightRequest={400}
        visible={true}
    >
        <box className={"settings-wallpaper-container"} orientation={Gtk.Orientation.VERTICAL}>
            <label className={"settings-wallpaper-title"} label="Wallpaper"/>
            <Wallpaper/>
        </box>
    </MoveableWindow>
}
