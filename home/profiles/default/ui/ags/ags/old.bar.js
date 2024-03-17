import { Window, CenterBox, Box, Label } from 'resource:///com/github/Aylur/ags/widget.js';
import { execAsync } from 'resource:///com/github/Aylur/ags/utils.js';

const systemtray = await Service.import('systemtray')

const Clock = () =>
    Label({
        className: 'clock',
    }).poll(1000, (self) =>
        execAsync(['date', '+%-I:%M%p'])
            .then((date) => (self.label = date))
            .catch(print)
    );

const SysTrayItem = item => Widget.Button({
    className: 'systray-item',
    child: Widget.Icon().bind('icon', item, 'icon'),
    tooltipMarkup: item.bind('tooltip_markup'),
    onPrimaryClick: (_, event) => item.activate(event),
    onSecondaryClick: (_, event) => item.openMenu(event),
});

const sysTray = () =>
  Widget.Box({
    className: 'systray',
    children: systemtray.bind('items').as(i => i.map(SysTrayItem))
  });

const Right = () =>
    Box({
        children: [
          sysTray()
        ],
    });

const Center = () =>
    Box({
        children: [
            Clock()
        ],
    });

const Left = () =>
    Box({
        hpack: 'end',
        children: [
        ],
    });

export const myBar = ({ monitor = 0 } = {}) =>
    Window({
        name: `bar${monitor || ''}`,
        className: 'bar',
        monitor: monitor,
        anchor: ['top', 'left', 'right'],
        exclusivity: 'exclusive',
        child: CenterBox({
            className: 'bar shadow',
            startWidget: Right(),
            centerWidget: Center(),
            endWidget: Left(),
        }),
    })


