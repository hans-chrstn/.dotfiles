import WirelessSys from './modules/WirelessSys.js';
import BatterySys from './modules/BatterySys.js';
import ClockSys from './modules/ClockSys.js';
import WeatherSys from './modules/WeatherSys.js';
import { Widget } from '../../utils/imports.js';

export const SystemLeft = () => Widget.Box({
    class_name: 'system_left',
    children: [
        WeatherSys(),
        BatterySys(),
        WirelessSys(),
        
    ],
});

export const SystemRight = () => Widget.Box({
    class_name: 'system_right',
    children: [
        ClockSys(),
    ],
});





