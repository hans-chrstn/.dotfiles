import { audioSlider } from "modules/osd/index"
export default () => {
  return Widget.Box({
    className: 'audio',
    children: [
      Widget.Box({
        children: [
          audioSlider('speaker'),
        ],
      }),
      Widget.Box({
        children: [
          audioSlider('microphone'),
        ],
      }),
    ],
  })
}
