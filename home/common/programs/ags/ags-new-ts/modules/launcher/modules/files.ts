export default () => {
  function FileButton(dir: string, name: string) {
    return Widget.Button({
      className: `files-${name}`,
      onClicked: () => {
        Utils.execAsync(['wezterm', 'start', '--', 'yazi', dir])
        App.closeWindow('applauncher')
        App.closeWindow('powermenu')
      },
      child: Widget.Label(name)
    });
  } 

  return Widget.Box({
    className: 'files',
    hexpand: false,
    vexpand: false,
    vertical: true,
    children: [
      FileButton('/', 'ThisPC'),
      FileButton('~', 'Home'),
      FileButton('~/Documents', 'Documents'),
      FileButton('~/Downloads', 'Downloads'),
      FileButton('~/Photos', 'Photos'),
    ],
  });
}
