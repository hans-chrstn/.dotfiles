import Date from '../../../variables/Date.js';
import { Widget } from '../../../utils/imports.js';

export default () => Widget.Box({
    class_name: 'clock_box',
    children: [
        Date({
            format: '%H:%M',
            class_name: 'icon'
        }), 
    ],
    
});
