import { Widget } from '../../../../utils/imports.js';

const Calendar = () => Widget.Box({
    vertical: true,
    class_name: 'calendar_box',
    children: [
        Widget.Calendar({
            sensitive: true,
            class_name: 'calendar_label',
            showDayNames: true,
            showDetails: true,
            showHeading: true,
            showWeekNumbers: false,
        }),
    ],
    
});

export default () => Widget.Window({
    name: 'calendar',
    visible: false,
    keymode: 'on-demand',
    exclusivity: 'exclusive', 
    anchor: ['top', 'right'],
    child: Calendar(),
});
