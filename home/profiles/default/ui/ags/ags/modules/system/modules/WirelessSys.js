import { Network, Widget, Utils } from '../../../utils/imports.js';
import Icon from '../../icons/icons.js';
/* 
    just some weird shenanigans stuff that i thought about
*/

export default () => Widget.EventBox({
    on_hover: (box) => {
        box.child.children[1].reveal_child = true;
    },
    on_hover_lost: (box) => {
        box.child.children[1].reveal_child = false;
    },
    on_primary_click: () => {
        Utils.execAsync(['nmcli', 'radio']).then(output => {
            const wifiArg = output.trim().split('\n')[1].split(/\s+/)[1].trim(); 
            const wifiStatus = (wifiArg === 'enabled') ? 'off' : 'on';
            Utils.execAsync(['nmcli', 'radio', 'wifi', wifiStatus]);
        });
    },
    child: Widget.Box({
        hpack: 'end',
        children: [
            Widget.Label({
                class_name: 'icon',
                setup: self => { self 
                    .hook(Network, (self) => {
                        self.label = Network.wifi.internet === 'connected' ? 
                            Network.wifi.strength < 30 ? Icon.wifi.weak :
                                Network.wifi.strength < 60 ? Icon.wifi.average :
                                    Network.wifi.strength < 80 ? Icon.wifi.good :
                                        Icon.wifi.great :
                            Icon.wifi.disabled;
                    });
                },
            }),
            Widget.Revealer({
                class_name: 'icon',
                reveal_child: false,
                transition: 'slide_left',
                transitionDuration: 1000,
                child: Widget.Button({
                    on_primary_click: () => Utils.exec('nm-connection-editor'),
                    child: Widget.Label({
                        class_name: 'icon_revealer',
                        setup: self => { self
                            .hook(Network, (self) => {
                                self.label = Network.wifi.internet === 'disconnected' ?
                                    'N/A' :
                                    Network.wifi.ssid;
                            });
                        },
                    })
                })
            }),
        ],
    })
    
});
