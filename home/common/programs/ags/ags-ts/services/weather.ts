import Icons from 'lib/icons';
class Weather extends Service {
  static {
    Service.register(
      this,
      {},
      {
        'feels_like': ['int'],
        'temp': ['int'],
        'icon': ['string'],
        'description': ['string'],
        'weather_data': ['jsobject'],
        'area_name': ['string'],
        'humidity': ['int'],
        'windspeed': ['int'],
      }
    );
  }

  private _feels_like: number = 0;
  private _temp: number = 0;
  private _description: string = '';
  private _icon: string = '';
  private _weather_data = {};
  private _url: string = 'http://wttr.in/?format=j1';
  private _decoder: TextDecoder = new TextDecoder();
  private _area_name: string = '';
  private _humidity: number = 0;
  private _windspeed: number = 0;

  get feels_like(): number {
    return this._feels_like;
  }

  get temp(): number {
    return this._temp;
  }

  get icon(): string {
    return this._icon;
  }

  get description(): string {
    return this._description;
  }

  get weather_data() {
    return this._weather_data;
  }

  get area_name(): string {
    return this._area_name;
  }

  get humidity(): number {
    return this._humidity;
  }

  get windspeed(): number {
    return this._windspeed;
  }

  constructor() {
    super();
    Utils.interval(900000, this._getWeather.bind(this));
  }

  _getWeather() {
    Utils.fetch(this._url)
      .then((result) => result.json())
      .then((result) => {
        const weatherData = result;
        this.updateProperty(
          'weather_data',
          weatherData,
        );
        this.updateProperty(
          'feels_like',
          Number(weatherData['current_condition'][0]['FeelsLikeC']),
        );
        this.updateProperty(
          'temp',
          Number(weatherData['current_condition'][0]['temp_C']),
        );
        this.updateProperty(
          'description',
          weatherData['current_condition'][0]['weatherDesc'][0]['value'],
        );
        this.updateProperty(
          'area_name',
          weatherData['nearest_area'][0]['areaName'][0]['value']
        );
        this.updateProperty(
          'humidity',
          Number(weatherData['current_condition'][0]['humidity']),
        )
        this.updateProperty(
          'windspeed',
          Number(weatherData['current_condition'][0]['windspeedKmph'])
        );
        const weatherCode = weatherData['current_condition'][0]['weatherCode'];
        const sunriseHour = parseInt(
          weatherData['weather'][0]['astronomy'][0]['sunrise'].split(':')[0],
        );
        const sunsetHour = parseInt(
          weatherData['weather'][0]['astronomy'][0]['sunset'].split(':')[0],
        ) + 12;
        const curHour = new Date().getHours();
        const timeOfDay = curHour >= sunriseHour && curHour <= sunsetHour ? 'day' : 'night';
        this.updateProperty(
          'icon',
          Icons.weather[timeOfDay][weatherCode] || Icons.weather['day'][weatherCode] || '',
        );
      })
  }
}

Object.assign(globalThis, { Weather })
export default new Weather();
