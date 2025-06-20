import { bind, exec, GLib} from "astal";
import { App, Astal, Gtk } from "astal/gtk3"
import { FileChooserButton } from "../lib/fileChooserButton";
import { MoveableWindow } from "../lib/moveableWindow";
import { WallpaperPreview } from "../../services/wallpaper";

let wallpaper_path = `${GLib.get_current_dir()}/assets/wallpaper`;
let name: string = "Settings";

function Wallpaper(): JSX.Element {
    const file = <FileChooserButton
        className={"settings-wallpaper-inner-filechooser"}
        onFileSet={(self) => {
            const uri = self.get_filename();
            if (uri !== null) {
              wallpaper_path = uri;
              WallpaperPreview.get_default().wallpaperPath = wallpaper_path;
            }
            console.log("Uri: ", self.get_uri());
            console.log("File: ", self.get_file());
            console.log("WallpaperPreview: ", bind(WallpaperPreview.get_default(), "wallpaperUri").get());
        }}
    />

  const preview = (
    <box
      className={"settings-wallpaper-inner-preview"}
      css={`
        background-image: url('${bind(WallpaperPreview.get_default(), "wallpaperUri").get()}');
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
        min-width: 200px;
        min-height: 200px;
      `}
    />
  );

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
