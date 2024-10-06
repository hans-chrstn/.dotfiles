type DeviceType = 'speaker' | 'microphone';
const audio = await Service.import('audio')

export const audioSlider = (device: DeviceType) => Widget.Slider({
  hexpand: true,
  drawValue: false,
  max: audio.maxStreamVolume,
  min: 0,
  className: 'audio-slider',
  onChange: ({ value }) => audio[device].volume = value,
  value: audio[device].bind('volume')
})

function OSD() {

  const audioIcon = Widget.Button({
    onClicked: () => audio.speaker.is_muted = !audio.speaker.is_muted,
    child: Widget.Icon().hook(audio, (self) => {
      if (!audio.speaker)
        return;
      const category = {
        101: 'overamplified',
        67: 'high',
        34: 'medium',
        1: 'low',
        0: 'muted',
      };
      const icon = audio.speaker.is_muted ? 0 : [101, 67, 34, 1, 0].find(
        threshold => threshold <= audio.speaker.volume * 100);
        self.icon = `audio-volume-${category[icon]}-symbolic`;
    }, 'speaker-changed'),
  })
  const revealer = Widget.Revealer({
    transition: 'crossfade',
    child: Widget.CenterBox({
      className: 'audio-popup',
      startWidget: audioIcon,
      endWidget: audioSlider('speaker'),
    })
  })

  let count = 0
  function show() {
    revealer.reveal_child = true
    count++
    Utils.timeout(2500, () => {
      count--
      if (count === 0)
        revealer.reveal_child = false
    })
  }

  return revealer.hook(audio.speaker, () => show(), 'notify::volume')
}

export default (monitor: number) =>  Widget.Window({
  name: `audio-popup-${monitor}`,
  monitor,
  layer: 'top',
  keymode: 'on-demand',
  anchor: ['bottom'],
  visible: true,
  child: OSD(),
})
