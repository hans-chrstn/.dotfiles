import { Network, Widget } from '../../../utils/imports.js';
/* 
    just some weird shenanigans stuff that i thought about
*/
const updateWirelessIcon = () => {
    if (Network.wifi.internet == 'connected') {
        const strength = Network.wifi.strength;
        if (strength < 26) {
            return '󰤟';
        }
        else if (strength < 51) {
            return '󰤢';
        }
        else if (strength < 76) {
            return '󰤢';
        }
        else {
            return '󰤨';
        } 
    } 
    return '󰤯'
};

export default () => Widget.EventBox({
    on_hover: (box) => {
        box.child.children[1].reveal_child = true 
    },
    on_hover_lost: (box) => {
        box.child.children[1].reveal_child = false
    },
    child: Widget.Box({
        hpack: 'end',
        children: [
            Widget.Label({
                class_name: 'icon',
                label: updateWirelessIcon(),
                setup: self => { self 
                    .hook(Network, (self) => {
                        self.label = updateWirelessIcon()
                    })
                }, 
            }),
            Widget.Revealer({
                class_name: 'icon',
                reveal_child: false,
                transition: 'slide_left',
                transitionDuration: 1000,
                child: Widget.Label({
                    class_name: 'icon_revealer',
                    label: Network.wifi.bind('ssid')
                        .transform(ssid => ssid || 'N/A')
                })
            }),
        ],
    })
    
});
