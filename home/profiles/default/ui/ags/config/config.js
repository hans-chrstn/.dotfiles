const Bar = (monitor = 0) => Widget.Window({
    monitor,
    name: `bar${monitor}`,
    anchor: ['top', 'left', 'right'],
    child: Widget.Label({ label: date.bind() })
})

const date = Variable('', {
    poll: [1000, 'date'],
})

App.config({
    windows: [
        Bar(0), // can be instantiated for each monitor
        Bar(1),
    ],
})
