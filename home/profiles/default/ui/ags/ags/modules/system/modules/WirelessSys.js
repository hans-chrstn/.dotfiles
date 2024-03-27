import { Network } from '../../../utils/imports.js';
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

export default () => Widget.Box({
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
    ],
});
