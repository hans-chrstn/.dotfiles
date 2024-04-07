import icons from '../../icons/icons.js';
import { Utils, Service } from '../../../utils/imports.js';

class WeatherService extends Service {
    static {
        Service.register(this, {},
            {
                'feels-like': ['int'],
                'temp': ['int'],
                'icon': ['string'],
                'description': ['string'],
                'weather-data': ['jsobject'],
            });
    }

    _feels_like = 0;
    _temp = 0;
    _description = '';
    _icon = '';
    _weather_data = {};
    _url = 'http://wttr.in/?format=j1';
    _decoder = new TextDecoder();

    get feels_like() {
        return this._feels_like;
    }

    get temp() {
        return this._temp;
    }

    get icon() {
        return this._icon;
    }

    get description() {
        return this._description;
    }

    get weather_data() {
        return this._weather_data;
    }

    constructor() {
        super();
        Utils.interval(900000, this._getWeather.bind(this)); // every 15 min
    }

    _getWeather() {

        Utils.fetch(this._url)
            .then(result => result.json())
            .then(result => {
                const weatherData = result;
                this.updateProperty('weather_data', weatherData);
                this.updateProperty('feels_like', Number(weatherData['current_condition'][0]['FeelsLikeC']));
                this.updateProperty('temp', Number(weatherData['current_condition'][0]['temp_C']));
                this.updateProperty('description', weatherData['current_condition'][0]['weatherDesc'][0]['value']);
                const weatherCode = weatherData['current_condition'][0]['weatherCode'];
                const sunriseHour = parseInt(weatherData['weather'][0]['astronomy'][0]['sunrise'].split(':')[0]); //old is parseint on both sunrise/setHour eg. 'parseInt()'
                const sunsetHour = parseInt(weatherData['weather'][0]['astronomy'][0]['sunset'].split(':')[0]) + 12; // + 12 converts to 24hr lolz
                const curHour = new Date().getHours();
                const timeOfDay = curHour >= sunriseHour && curHour <= sunsetHour ? 'day' : 'night';
                this.updateProperty('icon', icons.weather[timeOfDay][weatherCode]
                || icons.weather['day'][weatherCode] // fallback to day
                || '');
                //console.log('Sunrise Hour:', sunriseHour);
                //console.log('Sunset Hour:', sunsetHour);
                //console.log('Current Hour:', curHour);
            })
            .catch(logError);

            
    }
}

const service = new WeatherService();
export default service;
globalThis.weather = service;
