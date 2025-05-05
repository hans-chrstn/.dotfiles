import GObject, { register, property, GLib } from 'astal/gobject';

@register({GTypeName: "WallpaperPreview"})
export class WallpaperPreview extends GObject.Object {
    static instance: WallpaperPreview
    static get_default() {
        if (!this.instance)
            this.instance = new WallpaperPreview();
        return this.instance
    }

    constructor() {
        super();
    }

    #wallpaperPath: string = '';

    @property(String)
    public get wallpaperPath() : string {
        return
    }
    public set wallpaperPath(filePath: string = `${GLib.get_current_dir}/assets/wallpaper`) : string {
        return
    }
    
}
