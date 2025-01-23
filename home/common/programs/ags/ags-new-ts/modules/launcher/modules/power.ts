import icons from "lib/icons"

export default () => {
  const PowerButton = (icon: string,  cmd: string | string[], name?: string) => Widget.Button({
    className: name? name : 'power-button',
    onClicked: () => Utils.execAsync(cmd),
    child: Widget.Label({
      label: icon,
    })
  })

  return Widget.Box({
    className: 'power',
    spacing: 12,
    children: [
      PowerButton(icons.power.lock, 'hyprlock'),
      PowerButton(icons.power.logout, ['loginctl', 'kill-user', '1001']),
      PowerButton(icons.power.reboot, ['systemctl', 'reboot']),
      PowerButton(icons.power.suspend, ['systemctl', 'suspend']),
      PowerButton(icons.power.shutdown, ['shutdown', '-h', 'now']),
    ],
  })

}
