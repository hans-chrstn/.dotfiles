import Icons from 'lib/Icons.ts';

export default () => Widget.Button({
  cssClasses: ['power'],
  on_click: () => App.toggleWindow('powermenu'),
  child: Widget.Label({
    cssClasses: ['power-icon'],
    label: Icons.power.powerbutton,
  })
})
