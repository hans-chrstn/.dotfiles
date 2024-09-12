import { cmd } from "lib/utils"

class Wallpaper extends Service {
  static {
    Service.register(this, {}, {
      'wallpaper': ['string'],
    })
  } 

  async #setWallpaper(path: string) {
    await cmd(`hyprctl hyprpaper preload ${path}`)
    await cmd(`hyprctl hyprpaper wallpaper ${path}`)
    this.changed('wallpaper')
  }

  get wallpaper() { return String(cmd(`hyprctl hyprpaper listloaded`)) }

  readonly set = (path: string) => { this.#setWallpaper(path) }
}

export default new Wallpaper();
