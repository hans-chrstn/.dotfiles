import { timeout, Variable } from "astal";
import Brightness from "../../services/brightness";
import AstalWp from "gi://AstalWp";
import { Gtk } from "astal/gtk3";

export function OnScreenProgess({ visible}: { visible: Variable<boolean> } ) {
    const brightness = Brightness.get_default();
    const speaker = AstalWp.get_default()!.get_default_speaker();

    const iconName = Variable("");
    const value = Variable(0);

    let count = 0;
    function show(v: number, icon: string) {
        visible.set(true)
        value.set(v);
        iconName.set(icon);
        count++;
        timeout(2000, () => {
            count--;
            if (count === 0)
                visible.set(false);
        })
    }

    const osd = <box className={"OSD"}>
        <icon icon={iconName()} />
        <levelbar valign={Gtk.Align.CENTER} widthRequest={100} value={value()} />
        <label label={value(v => `${Math.floor(v * 100)}%`)}/>
    </box>

    return (
        <revealer
            setup={(self) => {
                self.hook(brightness, 'notify::screen', () => {
                    show(brightness.screen, 'display-brightness-symbolic')
                })

                if (speaker) {
                    self.hook(speaker, 'notify::volume', () => {
                        show(speaker.volume, speaker.volumeIcon)
                    })
                }
            }}
            revealChild={visible()}
            transitionType={Gtk.RevealerTransitionType.SLIDE_UP}
            child={osd}
        />
    )
}
