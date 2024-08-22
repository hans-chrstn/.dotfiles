import WirelessSys from './modules/WirelessSys.js';
import BatterySys from './modules/BatterySys.js';
import ClockSys from './modules/ClockSys.js';
import WeatherSys from './modules/WeatherSys.js';
import Bluez from './modules/Bluez.js';
import { Widget, SystemTray } from '../../utils/imports.js';
import Gdk from 'gi://Gdk?version=3.0';

const SysTrayItem = item => Widget.Button({
    child: Widget.Icon({
        class_name: 'icon',
    }).bind('icon', item, 'icon'),
    tooltipMarkup: item.bind('tooltip-markup'),
    on_clicked: btn => item.menu?.popup_at_widget(btn, Gdk.Gravity.SOUTH, Gdk.Gravity.NORTH, null), 
    on_secondary_click: btn => item.menu?.popup_at_widget(btn, Gdk.Gravity.SOUTH, Gdk.Gravity.NORTH, null), 
});

export const SysTray = () => Widget.Box({ 
    class_name: 'sys_tray'
}).bind('children', SystemTray, 'items', i => 
    i.map(SysTrayItem));

export const SystemLeft = () => Widget.Box({
    class_name: 'system_left',
    children: [
        WeatherSys(),
        BatterySys(),
        Bluez(),
        WirelessSys(),
        
    ],
});

export const SystemRight = () => Widget.Box({
    class_name: 'system_right',
    children: [
        ClockSys(),
    ],
});





