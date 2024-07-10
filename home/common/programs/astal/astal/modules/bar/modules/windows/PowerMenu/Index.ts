import PowerMenu from 'services/PowerMenu';
import Icons from 'lib/Icons';

const PowerButton = (action: string) => Widget.Button({
  on_click: () => PowerMenu.action(action),
  child: Widget.Label({
    label: Icons.power[action],
    cssClasses: [`powerm-${action}`],
  })
});

export default () => Widget.Window({
  name: 'powermenu',
  visible: false,
  keymode: 'on-demand',
  anchor: ['top', 'right'],
  layer: 'top',
  child: Widget.Box({
    cssClasses: ['powerm'],
    vertical: true,
    children: [
      PowerButton('suspend'),
      PowerButton('reboot'),
      PowerButton('shutdown'),
      PowerButton('logout'),
      Widget.Button({
        cssClasses: ['powerm-lock'],
        on_click: () => Utils.execAsync(['hyprlock', '-c', '/home/hayato/.dotfiles/home/common/programs/hyprland/config/hyprlock.conf']),
        child: Widget.Label(Icons.power.lock),
      })
    ],
  })
})


