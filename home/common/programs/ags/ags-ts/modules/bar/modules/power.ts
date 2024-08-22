import Icons from 'lib/icons';
export default () => Widget.Button({
  className: 'power',
  on_clicked: () => App.toggleWindow('power-menu'),
  child: Widget.Label({
    className: 'power-icon',
    label: Icons.power.powerbutton,
  })
})
