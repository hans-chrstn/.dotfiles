const testLabel = Widget.Label({
  label: 'test',
})

const testBar = Widget.Window({
  name: 'bar'.
  anchor: ['top', 'left', 'right'],
  child: myLabel,

})

export default {
    windows: [
	testBar(0),
	testBar(1),
    ],
}
