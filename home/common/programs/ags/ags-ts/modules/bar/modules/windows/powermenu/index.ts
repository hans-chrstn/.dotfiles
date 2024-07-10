import Icons from 'lib/icons';
import PowerMenu from 'services/powermenu';

const PowerButton = (action: string) => Widget.Button({
  on_clicked: () => PowerMenu.action(action),
  child: Widget.Label({
    label: Icons.power[action],
    className: `power-menu-${action}`,
  }),
});

export default () => Widget.Window({
  name: 'power-menu',
  visible: false,
  keymode: 'on-demand',
  anchor: ['top', 'right'],
  layer: 'top',
  setup: self => self.keybind('Escape', () => {
    App.closeWindow('power-menu');
  }),
  child: Widget.Box({
    className: 'power-menu',
    vertical: true,
    children: [
      PowerButton('suspend'),
      PowerButton('reboot'),
      PowerButton('shutdown'),
      PowerButton('logout'),
      Widget.Button({
        className: 'power-menu-lock',
        on_clicked: () => Utils.execAsync(['hyprlock', '-c', '/home/hayato/.dotfiles/home/common/programs/hyprland/config/hyprlock.conf']),
        child: Widget.Label(Icons.power.lock)
      })
    ],
  }),
});
