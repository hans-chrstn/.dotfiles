import Gdk from 'types/@girs/gdk-4.0/gdk-4.0';
import Gtk from 'types/@girs/gtk-4.0/gtk-4.0';

export function range(length: number, start: number = 1) {
	return Array.from({ length }, (_, i) => i + start);
}

export function forMonitors(widget: (monitor: number) => Gtk.Window) {
	const n = Gdk.Display.get_default()?.get_monitors().get_n_items() || 1;
	return range(n, 0).map(widget).flat(1);
}

export async function reloadCss() {
	Utils.exec(`sassc ${App.configDir}/style/main.scss ${App.configDir}/style.css`);
	App.resetCss();
	App.applyCss(`${App.configDir}/style.css`);
  console.log('[LOG] SCSS and Styles Applied')
}
