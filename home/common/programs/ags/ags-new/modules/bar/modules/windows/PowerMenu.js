import { Widget, Utils } from '../../../../lib/Imports.js';
import Icons from '../../../icons/Icons.js';
import PowerMenu from '../../../services/PowerMenu.js';


const SysButton = (action, name) => Widget.Button({
  on_clicked: () => PowerMenu.action(action),
  child: Widget.Box({
    children: [
      Widget.Label({
        label:Icons.power[action],
        class_name: name,
      }),
    ],
  }),
});

export default () => Widget.Window({
  name: 'powermenu',
  visible: false,
  keymode: 'on-demand',
  anchor: ['top', 'right'],
  layer: 'top',
  child: Widget.Box({
    spacing: 10,
    class_name: 'powermenu_box',
    children: [
      SysButton('suspend', 'powermenu_suspend'),
      SysButton('reboot', 'powermenu_reboot'),
      SysButton('shutdown', 'powermenu_shutdown'),
      SysButton('logout', 'powermenu_logout'),
      Widget.Button({
        on_clicked: () => Utils.execAsync(['hyprlock', '-c', '/home/hayato/.dotfiles/home/common/programs/hyprland/config/hyprlock.conf']),
        child: Widget.Label({
          label: Icons.power.lock,
          class_name: 'powermenu_lock',
        })
      })
    ],
  }),
});
