import { lookUpIcon } from "resource:///com/github/Aylur/ags/utils/etc.js";
import { Applications } from "imports";
import { Application } from "resource:///com/github/Aylur/ags/service/applications.js";

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
    },
  });
};

// let apps = Applications.query('').map(AppItem);
// const list = Widget.Box({
//   vertical: true,
//   children: apps,
// });
//
// function repopulate() {
//   apps = Applications.query('').map(AppItem);
//   list.children = apps
// };
//
// export const activeApps = Widget.Scrollable({
//   hscroll: 'never',
//   className: 'activeapps',
//   child: list,
// })
//
// const entry = Widget.Entry({
//   className: 'applauncher-entry',
//   onChange: ({ text }) => apps.forEach(i => {
//     i.visible = i.attribute.app.match(text);
//   }),
// });

// export default () => {
//   return Widget.EventBox({
//     onPrimaryClick: (box) => {
//       box.child.children[0].reveal_child = !box.child.children[0].reveal_child
//       if (box.child.children[0].reveal_child === true) {
//         repopulate();
//         entry.text = '';
//         entry.grab_focus();
//       }
//     },
//     child: Widget.Box({
//       className: 'powermenu-launcher',
//       children: [
//         Widget.Revealer({
//           reveal_child: false,
//           transition: 'slide_left',
//           transitionDuration: 1000,
//           child: Widget.Box({
//             vertical: true,
//             children: [
//               entry,
//             ],
//           }),
//         }),
//         Widget.Label({
//           label: '\ue68f',
//         }),
//       ],
//     })
//   })
// };

  // return Widget.Box({
  //   vertical: true,
  //   className: 'powermenu-launcher',
  //   child: Widget.Button({
  //     onClicked: () => {
  //     },
  //     child: Widget.Label({
  //       label: '\ue68f',
  //       truncate: 'start',
  //     })
  //   }),
  // })

const AppLauncher = () => {
  let apps = Applications.query('').map(AppItem);

  const list = Widget.Box({
    vertical: true,
    children: apps,
  });

  function repopulate() {
    apps = Applications.query('').map(AppItem);
    list.children = apps
  };

  const entry = Widget.Entry({
    className: 'applauncher-entry',
    on_accept: () => {
      if (apps[0]) {
        App.closeWindow('launcher');
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
