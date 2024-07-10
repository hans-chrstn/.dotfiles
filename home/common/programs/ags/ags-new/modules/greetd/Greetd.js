import { Widget, Greetd, App } from '../../lib/Imports.js';

const name = Widget.Entry({
    class_name: 'greetd_username',
    placeholder_text: 'Username',
    on_accept: () => password.grab_focus(),
})

const password = Widget.Entry({
    class_name: 'greetd_password',
    placeholder_text: 'Password',
    visibility: false,
    on_accept: () => {
        Greetd.login(name.text || '', password.text || '', App.closeWindow('greetd'))
            .catch(err => Widget.Label().label = JSON.stringify(err))
    },
})

const Greeter = () => Widget.Box({
  class_name: 'greetd_box',
  vertical: true,
  hpack: 'center',
  vpack: 'center',
  hexpand: true,
  vexpand: true,
  children: [
    name,
    password,
  ],
})
export default () => Widget.Window({
  name: 'greetd',
  anchor: ['top', 'left', 'right', 'bottom'],
  keymode: 'exclusive',
  visible: false,
  layer: 'top',
  child: Greeter(),
});
