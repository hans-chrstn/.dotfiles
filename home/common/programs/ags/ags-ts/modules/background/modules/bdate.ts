import { date } from 'lib/variables';
export default () => Widget.Box({
  className: 'bdate',
  vertical: true,
  children: [
    Widget.Box({
      hpack: 'end',
      vertical: false,
      child: Widget.Label({
        className: 'bdate-day',
        label: date(300000).bind('value').as((day) => day.format('%A') || '...')
      }),
    }),
    Widget.Box({
      hpack: 'end',
      vertical: false,
      child: Widget.Label({
        className: 'bdate-date',
        label: date(300000).bind('value').as((date) => date.format('%d %b %Y') || '...'),
      }),
    })
  ],
}); 
