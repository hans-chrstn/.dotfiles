import { Service, Utils } from '../../lib/Imports.js';

class Greeter extends Service {
  static {
    Service.register (
      this,
      {
        'cmd': ['string'],  
      },
    );
  }

  #cmd = '';

  #user = String(Utils.exec('echo $USER'));
  
  get cmd() {
    return this.#cmd;
  }
}


