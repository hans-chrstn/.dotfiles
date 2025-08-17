import { monitorFile, readFileAsync } from 'astal';
import GObject, { register, property, GLib } from 'astal/gobject';

@register({ GTypeName: "WallpaperPreview" })
export class WallpaperPreview extends GObject.Object {
  static instance: WallpaperPreview;

  static get_default() {
    if (!this.instance)
      this.instance = new WallpaperPreview();
    return this.instance;
  }

  // use _ prefix instead of #
  _wallpaperPath: string = `${GLib.get_current_dir()}/assets/wallpaper`;

  @property(String)
  get wallpaperPath(): string {
    return this._wallpaperPath;
  }

  set wallpaperPath(value: string) {
    if (this._wallpaperPath !== value) {
      this._wallpaperPath = value;
      print(`[WallpaperPreview] wallpaperPath changed to: ${value}`);
      this.notify("wallpaperPath");
      this.notify("wallpaperUri");
    }
  }

  @property(String)
  get wallpaperUri(): string {
    return GLib.filename_to_uri(this.wallpaperPath, null);
  }

  constructor() {
    super();
    monitorFile(this._wallpaperPath, (filePath) => {
      this.wallpaperPath = filePath;
    });
  }
}

