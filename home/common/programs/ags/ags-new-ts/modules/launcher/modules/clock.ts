import { date } from 'lib/variables';
export default () => {
  const Clock = () => Widget.Label({
    className: 'clock-label',
    label: date(1000).bind('value').as((c) => c.format('%H:%M') || '...')
  });

  return Widget.Box({
    vertical: true,
    className: 'clock',
    child: Clock(),
  })
};
