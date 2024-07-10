export type Action = 'suspend' | 'reboot' | 'logout' | 'shutdown' ;
class PowerMenu extends Service {
  static {
    Service.register(
      this,
      {},
      {
        title: ['string'],
        cmd: ['string'],
      },
    );
  }

  _title: string = '';
  _cmd: string = '';

  get title() {
    return this._title;
  }

  get cmd() {
    return this._cmd;
  }

  action(action: Action) {
    [this._cmd, this._title] = {
      suspend: ['systemctl suspend', 'Suspend'],
      reboot: ['systemctl reboot', 'Reboot'],
      logout: ['loginctl kill-user 1000', 'Logout'],
      shutdown: ['shutdown now', 'Shutdown'],
    }[action];

    this.notify('cmd');
    this.notify('title');
    this.emit('changed');
    App.closeWindow('powermenu');
    App.openWindow('verify');
  }

  readonly shutdown = () => {
    this.action('shutdown')
  }

  readonly exec = () => {
    App.closeWindow('verify')
    Utils.exec(this._cmd)
  }
}

Object.assign(globalThis, { PowerMenu })
export default new PowerMenu();
