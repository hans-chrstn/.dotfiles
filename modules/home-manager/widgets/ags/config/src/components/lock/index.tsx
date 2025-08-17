import { idle, readFile } from "astal";
import { App, Astal, Gtk, Widget } from "astal/gtk3";
import AstalGreet from "gi://AstalGreet?version=0.1";

export default function Lockscreen(monitor: number) {
    const DEFAULT_USER = "mishima";
    const PASSWD_INDEX = {
        name: 0,
        uid: 2,
        gid: 3,
        desc: 4,
        home: 5,
        shell: 6,
    };

    const parsePasswd = (content: string) => {
        const split = content.split('\n');
        const parse = split.map((u) => {
            const user = u.split(':');
            return {
                name: user[PASSWD_INDEX.name],
                uid: Number(user[PASSWD_INDEX.uid]),
                gid: Number(user[PASSWD_INDEX.gid]),
                desc: user[PASSWD_INDEX.desc],
                home: user[PASSWD_INDEX.home],
                shell: user[PASSWD_INDEX.shell],
            };
        });
        return parse.filter((u) => {
            return u.uid >= 1000 &&
                !u.name.includes('nixbld') &&
                u.name !== 'nobody';
        });
    };

    const users = parsePasswd(readFile('/etc/passwd'));

    const dropdown = new Gtk.ComboBoxText();
    dropdown.show_all();

    users.forEach((u) => {
        dropdown.append(null, u.name);
    })

    const response = <label /> as Widget.Label;

    const password = (
        <entry
            placeholderText={"Password"}
            visibility={false}
            setup={(self) => idle(() => {
                self.grab_focus();
            })}

            onActivate={(self) => {
                AstalGreet.login(
                    dropdown.get_active_text() ?? '',
                    self.get_text() || '',
                    'Hyprland',
                    (_, res) => {
                        try {
                            AstalGreet.login_finish(res);
                            App.get_window("Lock")?.set_visible(false);
                            setTimeout(() => {
                                App.quit();
                            }, 500)
                        } catch (err) {
                            console.log(err);
                            response.set_label(JSON.stringify(err));
                        }
                    }
                )
            }}
        >

        </entry>
    );

    return (
        <window
            name={"Lock"}
            application={App}
            monitor={monitor}
            visible={false}
            keymode={Astal.Keymode.ON_DEMAND}
            setup={(self) => {
                setTimeout(() => {
                    self.set_visible(true);
                    password.grab_focus();
                }, 1000);
            }}
        >
            <box
                vertical
                halign={Gtk.Align.CENTER}
                valign={Gtk.Align.CENTER}
                hexpand
                vexpand
                className={"base"}
            >
                <box
                    vertical
                    halign={Gtk.Align.CENTER}
                    valign={Gtk.Align.CENTER}
                    hexpand
                    vexpand
                    className={"linked"}
                    setup={() => {
                        idle(() => {
                            const usernames = users.map((u) => u.name);
                            if (usernames.includes(DEFAULT_USER)) {
                                dropdown.set_active(usernames.indexOf(DEFAULT_USER));
                            }
                        })
                    }}
                >
                    {dropdown}
                    {password}
                </box>
                {response}
            </box>
        </window>
    )

}
