import { execAsync, timeout } from 'astal';
import GObject, { register, property } from 'astal/gobject';

@register({GTypeName: "Weather"})
export class Weather extends GObject.Object {
    static instance: Weather
    static get_default() {
        if (!this.instance)
            this.instance = new Weather();
        return this.instance
    }

    constructor() {
        super();
        this.#poll();
    }

    async #poll() {
        while (true) {
            try {
                const res = await execAsync(['curl', '-s', 'https://wttr.in/?format=j1']);
                const json = JSON.parse(res);
                const current_condition = json?.current_condition?.[0];
                const nearest_area = json?.nearest_area?.[0];

                if (current_condition && nearest_area) {
                    this.#_feels_like = current_condition.FeelsLikeC || '';
                    this.notify("feels_like")
                    this.#_temp = current_condition.temp_C || '';
                    this.notify("temp")
                    this.#_description = current_condition.weatherDesc?.[0]?.value || '';
                    this.notify("description");
                    this.#_icon = current_condition.weatherCode || ''; 
                    this.notify("icon");
                    this.#_area = nearest_area.areaName?.[0]?.value || '';
                    this.notify("area");
                    this.#_country = nearest_area.country?.[0]?.value || '';
                    this.notify("country");
                    this.#_region = nearest_area.region?.[0]?.value || '';
                    this.notify("region");
                }

            } catch (err) {
                console.error("Weather fetch failed: ", err);
            }
            await timeout(300000);
        }
    }

    #_feels_like: string = '';
    #_temp: string = '';
    #_description: string = '';
    #_icon: string = '';
    #_area: string = '';
    #_country: string = '';
    #_region: string = '';

    @property(String)
    public get feels_like() : string {
        return this.#_feels_like + '°C';
    }

    @property(String)
    public get temp() : string {
      return  this.#_temp + '°C';
    }

    @property(String)
    public get description() : string {
      return this.#_description;
    }

    @property(String)
    public get icon() : string {
      return this.#_icon;
    }

    @property(String)
    public get area() : string {
      return this.#_area;
    }


    @property(String)
    public get country() : string {
      return this.#_country;
    }

    @property(String)
    public get region() : string {
      return this.#_region;
    }
}
