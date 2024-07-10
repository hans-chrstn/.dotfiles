import PowerMenu from 'services/PowerMenu';
import { Stream } from 'types/service/audio';
const audio = await Service.import('audio')

export default () => Widget.Window({
  name: 'verify',
  visible: false,
  child: Widget.Box({
    cssClasses: ['verify'],
    vertical: true,
    children: [
      Widget.Box({
        cssClasses: ['verify-text-box'],
        vertical: true,
        children: [
          Widget.Label({
            cssClasses: ['verify-text-title'],
          }),
          Widget.Label({
            cssClasses: ['verify-text-desc'],
            label: 'Are you sure?',
          }),
        ],
      }),
      Widget.Box({
        cssClasses: ['verify-choice-box'],
        vexpand: true,
        vpack: 'end',
        homogeneous: true,
        children: [
          Widget.Button({
            cssClasses: ['verify-choice-button'],
            on_click: () => App.toggleWindow('verify'),
            child: Widget.Label({
              label: 'No',
              cssClasses: ['verify-choice-button-no'],
            }),
          }),
          Widget.Button({
            cssClasses: ['verify-choice-button'],
            on_click: () => {
              App.toggleWindow('verify');
              Utils.exec(PowerMenu.cmd);
            },
            child: Widget.Label({
              label: 'Yes',
              cssClasses: ['verify-choice-button-yes'],
            }),
          }),
        ],
      }),
    ],
  }),
});
