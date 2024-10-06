import { lookUpIcon } from "resource:///com/github/Aylur/ags/utils/etc.js";
import { Application } from "resource:///com/github/Aylur/ags/service/applications.js";
const applications = await Service.import('applications')

export const AppIcon = (app: Application) => {
  const icon = app.icon_name && lookUpIcon(app.icon_name)
    ? app.icon_name : 'image-missing';

  return Widget.Icon({
    class_name: 'applauncher-button-icon',
    icon: icon,
    size: 50,
  });
};

const AppItem = (app: Application) => {
  const title = Widget.Label({
    className: 'applauncher-button-title',
    label: app.name,
  });
  return Widget.Button({
    className: 'applauncher-button',
    attribute: { app },
    child: Widget.Box({
      className: 'applauncher-button-icon-title-box',
      children: [
        AppIcon(app),
        title,
      ],
    }),
    onClicked: () => {
      app.launch()
      App.closeWindow('powermenu')
      App.closeWindow('applauncher')
    },
  });
};

const AppLauncher = () => {
  let apps = applications.query('').map(AppItem);

  const list = Widget.Box({
    vertical: true,
    children: apps,
  });

  function repopulate() {
    apps = applications.query('').map(AppItem);
    list.children = apps
  };

  const entry = Widget.Entry({
    className: 'applauncher-entry',
    on_accept: () => {
      if (apps[0]) {
        App.closeWindow('applauncher');
        apps[0].attribute.app.launch();
      }
    },
    onChange: ({ text }) => apps.forEach(i => {
      i.visible = i.attribute.app.match(text);
    }),
  });

  return Widget.Box({
    vertical: true,
    className: 'applauncher',
    vexpand: false,
    hexpand: false,
    children: [
      entry,
      Widget.Scrollable({
        hscroll: 'never',
        className: 'applauncher-list',
        child: list,
      }),
    ],
    setup: self => {
      self.hook(App, (_, windowName, visible) => {
        if (windowName !== 'applauncher') return;
        if (visible) {
          repopulate();
          entry.text = '';
          entry.grab_focus();
        }
      })
    },
  })
};

export default () => Widget.Window({
  name: 'applauncher',
  visible: false,
  keymode: 'on-demand',
  layer: 'overlay',
  anchor: ['left'],
  setup: self => self.keybind('Escape', () => {
    App.closeWindow('applauncher')
  }),
  child: AppLauncher(),
});
