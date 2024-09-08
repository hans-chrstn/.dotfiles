import { Greetd } from "imports"
export default () => {
  const username = Widget.Entry({
    placeholderText: 'Username',
    onAccept: () => password.grab_focus(),
  })
  const password = Widget.Entry({
    placeholderText: 'Password',
    onAccept: () => {
      Greetd.login(username.text || '', password.text || '', 'Hyprland')
        .catch(err => response.label = JSON.stringify(err))
    },
  })
  const response = Widget.Label()
  return Widget.Window({
    name: `greetd`,
    keymode: 'exclusive',
    visible: false,
    anchor: ['top', 'left', 'right', 'bottom'],
    child: Widget.Box({
      vertical: true,
      hpack: 'center',
      vpack: 'center',
      hexpand: true,
      vexpand: true,
      children: [
        username,
        password,
        response,
      ],
    }),
  })
}
