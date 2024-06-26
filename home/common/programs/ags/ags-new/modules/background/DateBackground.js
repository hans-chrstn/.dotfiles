import { Widget } from '../../utils/imports.js';

export default () => Widget.Box({
  vertical: true,
  hpack: 'start',
  class_name: 'db_box',
  children: [
    Widget.Box({
      vertical: false,
      child: Widget.Label({
        class_name: 'day',
        setup: self => self.poll(300000, self => Utils.execAsync(['date', '+%A'])
          .then(day => self.label = day)),
      }),
    }),
    Widget.Box({
      vertical: false,
      child: Widget.Label({
        class_name: 'date',
        setup: self => self.poll(300000, self => Utils.execAsync(['date', '+%d %b %Y'])
          .then(date => self.label = date))
      }),
    }),
  ],
});

function getTimeOfDay(hour, min) {
    if (hour >= 1 && hour < 5) {
        return 'Dawn';
    } else if (hour === 5 && hour < 7) {
        return 'Morning';
    } else if (hour >= 7 && hour < 11) {
        return 'Early Morning';
    } else if (hour >= 11 && hour < 12) {
        return 'Late Morning';
    } else if (hour === 12 && min <= 29) {
        return 'Midday';
    } else if (hour === 12 && min >= 30) {
        return 'Afternoon';
    } else if (hour >= 13 && hour < 16) {
        return 'Early Afternoon';
    } else if (hour === 16 && min <= 59) {
        return 'Late Afternoon';
    } else if (hour >= 17 && hour < 19) {
        return 'Evening';
    } else if (hour >= 19 && hour < 21) {
        return 'Early Evening';
    } else if (hour >= 21 && hour <= 23) {
        return 'Late Evening';
    } else if (hour === 0 && min <= 59) {
        return 'Midnight';
    } else {
        return 'N/A';
    }
}
