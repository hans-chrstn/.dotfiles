import icons from "lib/icons";
import { MprisPlayer } from "types/service/mpris";
const mpris = await Service.import('mpris')
const getPlayer = () => mpris.getPlayer('spotify') || mpris.players[0] || null

export default (player: MprisPlayer = getPlayer()) => {
  const playbackArtist = Widget.Label({
    maxWidthChars: 20,
    label: player.track_artists.length > 0? player.bind('track_artists').as(p => p.join(', ')) : 'Not Playing'
  })

  const playbackTitle = Widget.Label({
    maxWidthChars: 20,
    label: player.track_title.length > 0? player.bind('track_title') : ''
  })

  const playbackImg = Widget.Box({
    css: player.bind('cover_path').as(p => `
      background-image: url('${p}');
      background-size: cover;
      border-radius: 12px;
      min-width: 200px;
      min-height: 200px;
    `)
  })

  const play = Widget.Button({
    onClicked: () => player.playPause,
    label: icons.mpris.play,
  })

  const revealer = Widget.Revealer({
    transition: 'crossfade',
    child: Widget.Box({
      vertical: true,
      children: [
        playbackArtist,
        playbackTitle,
        playbackImg,
      ],
    })
  })

  return Widget.Box({
    vertical: true,
    className: 'playback',
    setup: self => {
      self.hook(mpris, () => {
        self.child = revealer
        if (mpris.getPlayer !== null)
          revealer.reveal_child = true
        else revealer.reveal_child = false
      }, 'changed')
    }
  })
}
