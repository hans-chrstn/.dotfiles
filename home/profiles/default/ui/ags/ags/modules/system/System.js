import { Network } from '../../utils/imports.js';
import Clock from '../clock/Clock.js';
export const SystemLeft = () => Widget.Box({
    class_name: 'system_left',
    children: [
        BatterySys(),
        WifiSys(),
        
    ],
});

export const SystemRight = () => Widget.Box({
    class_name: 'system_right',
    children: [
        Clock(),
    ],
});

const updateNetworkIcon = () => {
    if (Network.wifi.internet == 'connected') 
        return '󰤨'
    return "󰤯"
};

const Test = () => Widget.Box({
    children: [
        Widget.Revealer({
            revealChild: false,
            transition: 'slide_right',
            transitionDuration: 1000,
            child: Widget.Label({
                label: Network.wifi.bind('ssid')
                    .transform(ssid => ssid || 'Unknown'),
            })
        }),
    ],
    
});

const WifiSys = () => Widget.Box({
    hpack: 'end',
    children: [
        Widget.Label({
            class_name: 'icon',
            label: updateNetworkIcon(),
            setup: self => { self 
                .hook(Network, (self) => {
                    self.label = updateNetworkIcon()
                })
            }, 
        }),
    ],
});

const BatterySys = () => Widget.Box({
    children: [
        Widget.Label({
            class_name: 'icon',
            label: '󰁹', 
        }),
    ],
});


