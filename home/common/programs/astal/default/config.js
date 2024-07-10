const time = Variable('', {
    poll: [1000, function() {
        return Date().toString()
    }],
})

const Bar = (/** @type {number} */ monitor) => Widget.Window({
    monitor,
    name: `bar${monitor}`,
    anchor: ['top', 'left', 'right'],
    exclusivity: 'exclusive',
    child: Widget.CenterBox({
        startWidget: Widget.Label({
            hpack: 'center',
            hexpand: true,
            label: 'Welcome to Astal!',
        }),
        endWidget: Widget.Label({
            hpack: 'center',
            hexpand: true,
            label: time.bind(),
        }),
    }),
})

App.config({
    windows: [Bar(0)],
})