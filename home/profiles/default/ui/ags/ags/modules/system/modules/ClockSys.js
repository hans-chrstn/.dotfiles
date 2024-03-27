import Date from '../../../variables/Date.js';

export default () => Widget.Box({
    class_name: 'clock_box',
    children: [
        Date({
            format: '%H:%M',
            class_name: 'icon'
        }), 
        Widget.EventBox({
            class_name: 'clock_button',
            cursor: 'pointer',
            onHover: () => {
                print('hello')
            },
        }),
    ],
    
})
