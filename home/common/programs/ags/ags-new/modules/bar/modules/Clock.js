import { Widget, Utils } from '../../../lib/Imports.js';
export default () => Widget.Box({
  class_name: 'clock_box',
  child: Widget.Label({
    class_name: 'clock_label',
    setup: self => self.poll(1000, self => Utils.execAsync(['date', '+%a %m/%d/%y - %H:%M:%S']).then(clock => self.label = clock)),
  }),
});
