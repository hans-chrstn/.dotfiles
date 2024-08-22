import { App, Service } from "../../lib/Imports.js";

class PowerMenu extends Service {
  static {
    Service.register(
      this,
      {},
      {
        title: ["string"],
        cmd: ["string"],
      },
    );
  }

  #title = "";
  #cmd = "";

  get title() {
    return this.#title;
  }

  get cmd() {
    return this.#cmd;
  }

  action(action) {
    [this.#cmd, this.#title] = {
      suspend: ["systemctl suspend", "Suspend"],
      reboot: ["systemctl reboot", "Reboot"],
      logout: ["loginctl kill-user 1000", "Logout"],
      shutdown: ["shutdown now", "Shutdown"],
    }[action];

    this.notify("cmd");
    this.notify("title");
    this.emit("changed");
    App.closeWindow("powermenu");
    App.openWindow("verify");
  }
}

export default new PowerMenu();
