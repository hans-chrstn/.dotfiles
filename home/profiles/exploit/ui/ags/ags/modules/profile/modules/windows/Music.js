import { Mpris, Widget } from '../../../../utils/imports.js';
import Icon from '../../../icons/icons.js';

const player = Mpris.getPlayer('spotify') || Mpris.getPlayer();

export default () => Widget.Box({
    children: [
        Widget.Button({
            on_primary_click: () => {
                if(!player) {
                    return;
                }
                player.previous();
            },
            child: Widget.Label({
                class_name: 'music_icon',
                label: Icon.mpris.previous,
            })
        }),
        Widget.Button({
            on_primary_click: () => {
                if(!player) {
                    return;
                }
                player.playPause();
            },
            child: Widget.Label({
                class_name: 'music_icon',
                label: Icon.mpris.play,
            }),
        }),
        Widget.Button({
            on_primary_click: () => {
                if(!player) {
                    return;
                }
                player.next();
            },
            child: Widget.Label({
                class_name: 'music_icon',
                label: Icon.mpris.next,
            })
        }),
        Widget.Label({
            class_name: 'music_label',
            max_width_chars: 8,
            truncate: 'end',
            setup: self => { self
                .hook(Mpris, (self) => {
                    if (!player) {
                        return;
                    }
                    self.label = 'Now Playing: ' + player?.track_title + ' - ' + player?.track_artists;
                });
            },
        })
    ],
});

