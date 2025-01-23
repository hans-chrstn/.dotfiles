import Gdk from "gi://Gdk";
import Gtk from "gi://Gtk?version=3.0";

export function range(length: number, start: number = 1) {
  return Array.from({ length }, (_, i) => i + start);
}

export function forMonitors(widget: (monitor: number) => Gtk.Window) {
  const n = Gdk.Display.get_default()?.get_n_monitors() || 1;
  return range(n, 0).flatMap(widget);
}

export function cmd(cmd: string | string[]) {
  return Utils.execAsync(cmd).catch(err => {
    console.error(typeof cmd === 'string' ? cmd : cmd.join(' '), err)
    return ''
  })
}

export function dependencies(...bins: string[]) {
  const missing = bins.filter(bin => Utils.exec({
    cmd: `which ${bin}`,
    out: () => false,
    err: () => true,
  }))

  if (missing.length > 0) {
    console.warn(Error(`missing dependencies: ${missing.join(', ')}`))
    Utils.notify(`missing dependencies: ${missing.join(', ')}`)
  }

  return missing.length === 0
}
