import { App, Widget } from '../../utils/imports.js';
import Icons from '../icons/Icons.js';

export default () => Widget.Button({
  class_name: 'power_button',
  setup: pb => pb.on('button-press-event', () => App.toggleWindow('powermenu')),
  child: Widget.Label({
    class_name: 'power_button_icon',
    label: Icons.power.powerbutton,
  }),
})
