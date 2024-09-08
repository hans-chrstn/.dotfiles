export default () => {
  const Pic = (size: number = 200, picture: string = `${App.configDir}/pfp.png`) => Widget.Icon({
    icon: picture,
    size: size, 
    className: 'profile-pic',
  });

  const Email = (email: string = 'hansestallo@gmail.com') => Widget.Label({
    label: email,
    className: 'profile-email',
  });

  return Widget.Button({
    onClicked: () => App.toggleWindow('bluetooth-menu'),
    child: Widget.Box({
      className: 'profile',
      vertical: true,
      hexpand: false,
      vexpand: false,
      children: [
        Pic(),
        Email(),
      ],
    }),
  });
};
