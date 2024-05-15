import { Widget } from '../../utils/imports.js';
import BatteryWidget from './modules/Battery.js';
import Clock from './modules/Clock.js';
import Weather from './modules/Weather.js';
import WirelessSys from './modules/WirelessSys.js';

export const SystemLeft = () => Widget.Box({
    class_name: 'sys_left',
    vertical: true,
    children: [
        Weather(),
        BatteryWidget(),
        WirelessSys(),
    ],
});

export const SystemRight = () => Widget.Box({
    class_name: 'sys_right',
    vertical: true,
    children: [
        Clock(),

    ],
});


