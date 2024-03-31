import { Mpris, Widget } from '../../../utils/imports.js';

const player = Mpris.getPlayer('spotify') || Mpris.getPlayer();

export default () => Widget.EventBox({
    on_primary_click: () => {
        if(!player) {
            return;
        }
        player.playPause();
    },
    on_secondary_click: () => {
        if(!player) {
            return;
        }
        player.next();
    },
    child: Widget.Box({
        children: [
            Widget.Label({
                class_name: 'music_label',
                max_width_chars: 10,
                truncate: 'end',
            }).hook(Mpris, (label) => {
                if(!player) {
                    return;
                }
                label.label = player?.track_title + ' - ' + player?.track_artists;
            })
        ],
    })
});

