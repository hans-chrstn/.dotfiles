import { uptime } from "lib/variables"

export default () => {
  return Widget.Box({
    className: 'uptime',
    child: Widget.Label({
      label: uptime(60000).bind().transform(up => `Days: ${Math.floor(up / 24)} Hours: ${Math.floor(up)}`)
    })
  })
}
