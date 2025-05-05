import { bind, exec } from 'astal';
import { App, Astal, Gtk } from 'astal/gtk3';
import { RoundCorner } from '../../utils/cairo';
import AstalMpris from 'gi://AstalMpris?version=0.1';

const mpris = AstalMpris.get_default();



function lengthStr(length: number) {
    const min = Math.floor(length / 60)
    const sec = Math.floor(length % 60)
    const sec0 = sec < 10 ? "0" : ""
    return `${min}:${sec0}${sec}`
}

export function MediaPlayer({ player, progressBar = true }: { player: AstalMpris.Player, progressBar: boolean } ) {
    const title = bind(player, 'title').as(t => t || 'Unknown Track')
    const artist = bind(player, 'artist').as(a => a || 'Unkown Artist')
    const coverArt = bind(player, 'coverArt').as(c => `background-image: url('${c}')`)
    const mpIcon = bind(player, 'entry').as(e => Astal.Icon.lookup_icon(e) ? e : 'audio-x-generic-symbolic')
    const position = bind(player, 'position').as(p => player.length > 0 ? p / player.length : 0);
    const playbackStatus = bind(player, 'playbackStatus').as(ps => 
        ps === AstalMpris.PlaybackStatus.PLAYING
            ? 'media-playback-pause-symbolic'
            : 'media-playback-start-symbolic'
    )

    return <box className={'mediaplayer'}>
        <box className={'cover-art'} css={coverArt}/>
        <box vertical>
            <box className={'title'}>
                <label truncate hexpand halign={Gtk.Align.START} label={title}/>
                <box className={'mediaplayer-media'} hexpand halign={Gtk.Align.END}>
                    <icon icon={mpIcon}/>
                </box>
            </box>
            <label halign={Gtk.Align.START} valign={Gtk.Align.START} vexpand wrap label={artist}/>
            <slider
                visible={bind(player, "length").as(l => l > 0) && progressBar}
                onDragged={({ value }) => player.position = value * player.length}
                value={position}
            />
            <centerbox className="actions">
                <label
                    hexpand
                    className={"position"}
                    halign={Gtk.Align.START}
                    visible={bind(player, "length").as(l => l > 0)}
                    label={bind(player, "position").as(lengthStr)}
                />
                <box>
                    <button
                        onClicked={() => player.previous()}
                        visible={bind(player, "canGoPrevious")}
                        child={<icon icon="media-skip-backward-symbolic"/>}
                    />
                    <button
                        onClicked={() => player.play_pause()}
                        visible={bind(player, "canControl")}
                        child={<icon icon={playbackStatus}/>}
                    />
                    <button
                        onClicked={() => player.next()}
                        visible={bind(player, "can_go_next")}
                        child={<icon icon={"media-skip-forward-symbolic"}/>}
                    />
                </box>
                <label
                    className={"length"}
                    hexpand
                    halign={Gtk.Align.END}
                    visible={bind(player, "length").as(l => l > 0)}
                    label={bind(player, "length").as(l => l > 0 ? lengthStr(l) : "0:00")}
                />
            </centerbox>
        </box>
    </box>
}


export default function Notch(monitor: number): JSX.Element {

    const dropdown = new Gtk.ComboBoxText;

    const leftcorner = <RoundCorner anchor='topleft' className='dynamic-notch-roundcorner-left' sizeX={30} sizeY={30}/>
    const rightcorner = <RoundCorner anchor='topright' className='dynamic-notch-roundcorner-right' sizeX={30} sizeY={30}/>

    const reveal = <revealer
        transition_type={Gtk.RevealerTransitionType.SLIDE_DOWN}
        transition_duration={500}
        reveal_child={false}
        child={bind(mpris, "players").as(arr => arr[0] ?
            <MediaPlayer player={arr[0]} progressBar={true}/> : null
        )}
    />

    const base = <box className={'dynamic-notch'} child={reveal}/>

    const event = <eventbox className={'dynamic-notch-container'}
        onClick={() => {
            exec('hyprctl keyword layerrule noanim,Notch')
            // base.toggleClassName('dynamic-notch-toggle', !base.className.includes('dynamic-notch-toggle'));
            // base.set_child_visible(!base.get_child_visible());
            reveal.reveal_child = !reveal.get_reveal_child();

        }}
    >
        <centerbox>{leftcorner}{base}{rightcorner}</centerbox>
    </eventbox>

    return (<window
        className={'Notch'}
        name={'Notch'}
        monitor={monitor}
        anchor={Astal.WindowAnchor.TOP}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        application={App}
        namespace={'Notch'}
    >
        {event}

    </window>)
}
