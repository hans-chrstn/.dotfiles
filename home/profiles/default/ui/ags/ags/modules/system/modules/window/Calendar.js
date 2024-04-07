import { Widget } from '../../../../utils/imports.js';
import { getCalendarLayout } from './CalendarLayout.js';


const Calendar = () => Widget.Box({
    vertical: true,
    class_name: 'calendar-cal',
    setup: (self) => {
        self.poll(10000, (self) => {
            const dates = getCalendarLayout();
            self.children = [
                Widget.Box({
                    homogeneous: true,
                    children: [
                        Widget.Label({
                            label: 'Mo',
                            hpack: 'center',
                            class_name: 'calendar-cell calendar-weekday'
                        }),
                        Widget.Label({
                            label: 'Tu',
                            hpack: 'center',
                            class_name: 'calendar-cell calendar-weekday'
                        }),
                        Widget.Label({
                            label: 'We',
                            hpack: 'center',
                            class_name: 'calendar-cell calendar-weekday'
                        }),
                        Widget.Label({
                            label: 'Th',
                            hpack: 'center',
                            class_name: 'calendar-cell calendar-weekday'
                        }),
                        Widget.Label({
                            label: 'Fr',
                            hpack: 'center',
                            class_name: 'calendar-cell calendar-weekday'
                        }),
                        Widget.Label({
                            label: 'Sa',
                            hpack: 'center',
                            class_name: 'calendar-cell calendar-weekend'
                        }),
                        Widget.Label({
                            label: 'Su',
                            hpack: 'center',
                            class_name: 'calendar-cell calendar-weekend'
                        }),
                    ]
                })
            ];
            // Concatenate dates boxes
            dates.forEach(s => {
                self.children.push(Widget.Box({
                    homogeneous: true,
                    setup: (sl) => {
                        sl.children = s.map(a => Widget.Label({
                            label: `${a['day']}`,
                            hpack: 'center',
                            class_name: `calendar-cell ${a['today'] == 0 ? 'calendar-month' : 'calendar-disabled'} ${a['istoday'] && 'calendar-active'}`
                        }));
                    }
                }));
            });
        });
    }
});


export default () => Widget.Window({
    name: 'calendar',
    visible: false,
    keymode: 'on-demand',
    exclusivity: 'exclusive', 
    anchor: ['top', 'right'],
    child: Calendar(),
});
