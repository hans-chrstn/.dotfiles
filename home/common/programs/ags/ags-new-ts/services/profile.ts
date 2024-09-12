import Gio from "types/@girs/gio-2.0/gio-2.0";

class Profile extends Service {
  static {
    Service.register(this, {}, {
      'profile': ['string'],
      'email': ['string'],
    })
  } 

  private _profile: string = '';
  private _email: string = '';

  constructor() {
    super()
  }

  readonly setProfile = (path: string) => {
    this._profile = path;
    this.updateProperty('profile', path);
    this.changed('profile')
  }

  readonly setEmail = (text: string) => {
    this._email = text;
    this.updateProperty('email', text);
    this.changed('email');
  }

  get profile(): string {
    return this._profile;
  }

  get email(): string {
    return this._email;
  }

}

export default new Profile();
