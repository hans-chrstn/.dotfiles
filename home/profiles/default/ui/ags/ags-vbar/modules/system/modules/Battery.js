import { Battery, Widget } from '../../../utils/imports.js';

export default () => Widget.EventBox({
    on_hover: (box) => {
        box.child.children[1].reveal_child = true;
    },
    on_hover_lost: (box) => {
        box.child.children[1].reveal_child = false;
    },
    child: Widget.Box({
        vertical: true,
        children: [
            Widget.Label({
                class_name: 'icon',
                label: updateBatteryIcon(),
                setup: self => { self
                    .hook(Battery, (self) => {
                        self.label = updateBatteryIcon();  
                    }); 
                },
            }),
            Widget.Revealer({
                reveal_child: false,
                transition: 'slide_down',
                transitionDuration: 1000,
                child: Widget.Label({
                    class_name: 'icon_revealer',
                    label: Battery.bind('percent')
                        .transform(percent => String(percent || 'N/A') + '%'),
                })
            }),
        ],
    })
});

const updateBatteryIcon = () => {
    const bpercent = Battery.percent;
    const bcharging = Battery.charging;
    
    const icons = {
        notCharging: {
            10: '󰁺',
            20: '󰁻',
            30: '󰁼',
            40: '󰁽',
            50: '󰁾',
            60: '󰁿',
            70: '󰂀',
            80: '󰂁',
            90: '󰂂',
            100: '󰁹'
            
        },
        charging: {
            10: '󰢜',
            20: '󰂆',
            30: '󰂇',
            40: '󰂈',
            50: '󰢝',
            60: '󰂉',
            70: '󰢞',
            80: '󰂊',
            90: '󰂋',
            100: '󰂅'
        },
    };

    /* 
    checks if bcharging is true. ? is a ternary operator asking 
    whether bcharging is true or not
    after that is the true : false
    icons.charging is true whereas icons.notCharging is false 
    */
    const selectedIcons = bcharging ? icons.charging : icons.notCharging;
    /* 
    here, icon is set to 'Unknown' at default.
    the for statement, we loop range through each number specified
    in the selectedIcons object.
    then, we check bpercent if its less than or equal to the 
    range we're considering.
    if the bpercent is less than or equal to the current range,
    we assign the corressponding icon from `selectedIcons` to the
    `icon` variable. 
    we use `break` to exit the loop. so that we dont need to check any further once we've found it.
    */
    let icon = 'N/A';
    for (let range in selectedIcons) {
        if (bpercent <= range) {
            icon = selectedIcons[range];
            break;
        }
    }
    return icon;
};
