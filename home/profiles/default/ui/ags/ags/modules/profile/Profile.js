import { Widget, App } from '../../utils/imports.js';
import MusicBar from './modules/Music.js';

export default () => Widget.EventBox({
    on_hover: (box) => {
        box.child.children[1].reveal_child = true;
    },
    on_hover_lost: (box) => {
        box.child.children[1].reveal_child = false;
    },
    child: Widget.Box({
        children: [
            Widget.Button({
                on_clicked: () => {
                    App.toggleWindow('');
                },
                child: Widget.Icon({
                    class_name: 'profile',
                    icon: `${App.configDir}/assets/pfp.png`,
                    size: 38,
                }),
            }),
            Widget.Revealer({
                reveal_child: false,
                transition: 'slide_left',
                transitionDuration: 1000,
                child: MusicBar(),
            }),
        ],
    })
});

