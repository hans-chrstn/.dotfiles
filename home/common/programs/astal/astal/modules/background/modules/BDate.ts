import { clock } from 'lib/Variables';
export default () => Widget.Box({
  cssClasses: ['bdate-box'],
  vertical: true,
  children: [
    Widget.Box({
      hpack: 'end',
      vertical: false,
      child: Widget.Label({
        cssClasses: ['bdate-day'],
        label: clock(300000)
          .bind('value')
          .as((date) => date.format('%A') || '...'),
      }),
    }),
    Widget.Box({
      hpack: 'end',
      vertical: false,
      child: Widget.Label({
        cssClasses: ['bdate-date'],
        label: clock(300000)
          .bind('value')
          .as((date) => date.format('%d %b %Y') || '...'),
      })
    }),
 ],
})
