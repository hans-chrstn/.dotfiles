import { Widget, App, Utils } from '../../../../lib/Imports.js';
import PowerMenu from '../../../services/PowerMenu.js';

export default () => Widget.Window({
  name: 'verify',
  expand: true,
  visible: false,
  child: Widget.Box({
    class_name: 'powermenu_verify_box',
    vertical: true,
    children: [
      Widget.Box({
        class_name: 'powermenu_verify_text_box',
        vertical: true,
        children: [
          Widget.Label({
            class_name: 'powermenu_verify_text_title',
          }),
          Widget.Label({
            class_name: 'powermenu_verify_text_desc',
            label: 'Are you sure?',
          }),
        ],
      }),
      Widget.Box({
        class_name: 'powermenu_verify_button_box',
        vexpand: true,
        vpack: 'end',
        homogeneous: true,
        children: [
          Widget.Button({
            child: Widget.Label('No'),
            on_clicked: () => App.toggleWindow('verify'),
          }),
          Widget.Button({
            child: Widget.Label('Yes'),
            on_clicked: () => Utils.exec(PowerMenu.cmd),
          }),
        ],
      }),
    ],
  })
});
