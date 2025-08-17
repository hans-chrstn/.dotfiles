import { bind } from "astal";
import { Astal, Gtk } from "astal/gtk3";
import AstalMpris from 'gi://AstalMpris?version=0.1';

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
                <label truncate hexpand={false} vexpand={false} halign={Gtk.Align.START} label={title}/>
            </box>
            <label halign={Gtk.Align.START} valign={Gtk.Align.START} vexpand wrap label={artist}/>
            <slider
                visible={bind(player, "length").as(l => l > 0) && progressBar}
                onDragged={({ value }) => player.position = value * player.length}
                value={position}
            />
            <box className="actions">
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
            </box>
        </box>
    </box>
}
