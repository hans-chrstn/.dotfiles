import { Audio } from 'imports';
type DeviceType = 'speaker' | 'microphone';

export default () => {
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
  });

  const audioSlider = (device: DeviceType) => Widget.Slider({
    hexpand: true,
    drawValue: false,
    max: Audio.maxStreamVolume,
    min: 0,
    className: 'audio-slider',
    onChange: ({ value }) => Audio[device].volume = value,
    value: Audio[device].bind('volume')
  });

  return Widget.Window({
    name: 'audio-popup',
    keymode: 'on-demand',
    layer: 'overlay',
    anchor: ['bottom'],
    visible: false,
    setup: self => {
      self.hook(Audio, (self) => {
        self.visible = true;
        Utils.timeout(2000, () => {
          self.visible = false;
        })
      }, 'speaker-changed'? 'speaker-changed' : 'microphone-changed');         
    },
    child: Widget.Box({
      className: 'audio-popup',
      children: [
        audioIcon,
        audioSlider('speaker'),
      ],
    }),
  })
}
