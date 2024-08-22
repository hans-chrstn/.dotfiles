import PowerMenu from 'services/powermenu';

export default () => Widget.Window({
  name: 'verify',
  visible: false,
  setup: self => self.keybind('Escape', () => {
    App.closeWindow('verify');
  }),
  child: Widget.Box({
    className: 'verify',
    vertical: true,
    children: [
      Widget.Box({
        className: 'verify-text-box',
        vertical: true,
        children: [
          Widget.Label({
            className: 'verify-text-title',
          }),
          Widget.Label({
            className: 'verify-text-desc',
            label: 'Are you sure?',
          })
        ],
      }),
      Widget.Box({
        className: 'verify-choice-box',
        vexpand: true,
        vpack: 'end',
        homogeneous: true,
        children: [
          Widget.Button({
            className: 'verify-choice-button',
            on_clicked: () => App.toggleWindow('verify'),
            child: Widget.Label({
              label: 'No',
              className: 'verify-choice-no',
            }),
          }),
          Widget.Button({
            className: 'verify-choice-button',
            on_clicked: () => {
              App.toggleWindow('verify')
              Utils.exec(PowerMenu.cmd)
            },
            child: Widget.Label({
              label: 'Yes',
              className: 'verify-choice-button-yes',
            }),
          }),
        ],
      }),
    ],
  }),
});
