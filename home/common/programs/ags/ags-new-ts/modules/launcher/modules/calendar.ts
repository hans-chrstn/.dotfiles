export default () => {

  const Calendar = () => Widget.Calendar({
    className: 'calendar-block',
    hexpand: true,
    hpack: 'center',
    showDetails: true,
    showDayNames: true,
    showWeekNumbers: false,
    showHeading: true,
  });

  return Widget.Box({
    className: 'calendar',
    vertical: true,
    children: [
      Calendar(),
    ],
  });
};
