import profile from "services/profile";

export default () => {
  const Pic = Widget.Overlay({
    className: 'preview',
    overlay: Widget.Box({
      vertical: true,
      className: 'preview-picker',
      child: Widget.FileChooserButton({
        onFileSet: ({ uri }) => {
          profile.setProfile(uri!.replace('file://', ''))
        },
      }),
    }),
    child: Widget.Box({
      vertical: true,
      className: 'preview-pic',
      css: profile.bind('profile').as((wp) => `
        background-image: url('${wp.length > 0 ? wp : `${App.configDir}/pfp.png`}')
      `),
    })
  })

  const Email = Widget.EventBox({
    onPrimaryClick: (box) => {
      box.child.children[2].reveal_child = !box.child.children[2].reveal_child
    },
    child: Widget.Box({
      vertical: true,
      children: [
        Widget.Label({
          className: 'profile-email',
          label: profile.bind('email').as((em) => em.length > 0 ? em : 'xuhiko13@gmail.com')
        }),
        Widget.Box({ hexpand: true }),
        Widget.Revealer({
          revealChild: false,
          transition: 'slide_down',
          child: Widget.Entry({
            placeholder_text: '',
            text: '',
            visibility: true,
            onAccept: ({ text }) => profile.setEmail(text || '')
          }),
        }),
      ]
    })
  })

  return Widget.Box({
    className: 'profile',
    vertical: true,
    hexpand: false,
    children: [
      Pic,
      Email,
    ],
  });
};
