import { Audio } from "imports"

type DeviceType = 'speaker' | 'microphone';
function OSD() {
  const audioIcon = Widget.Button({
    onClicked: () => Audio.speaker.is_muted = !Audio.speaker.is_muted,
    child: Widget.Icon().hook(Audio, (self) => {
      if (!Audio.speaker)
        return;
      const category = {
        101: 'overamplified',
        67: 'high',
        34: 'medium',
        1: 'low',
        0: 'muted',
      };
      const icon = Audio.speaker.is_muted ? 0 : [101, 67, 34, 1, 0].find(
        threshold => threshold <= Audio.speaker.volume * 100);
        self.icon = `audio-volume-${category[icon]}-symbolic`;
    }, 'speaker-changed'),
  })

  const audioSlider = (device: DeviceType) => Widget.Slider({
    hexpand: true,
    drawValue: false,
    max: Audio.maxStreamVolume,
    min: 0,
    className: 'audio-slider',
    onChange: ({ value }) => Audio[device].volume = value,
    value: Audio[device].bind('volume')
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

  return revealer.hook(Audio.speaker, () => show(), 'notify::volume')
}

export default () => {
  return Widget.Window({
    name: 'audio-popup',
    layer: 'top',
    keymode: 'on-demand',
    anchor: ['bottom'],
    visible: true,
    child: OSD(),
  })
}
