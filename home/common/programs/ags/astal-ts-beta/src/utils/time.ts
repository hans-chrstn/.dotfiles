import GLib from 'gi://GLib';
import { interval, Variable } from 'astal';

function getMeridiem() {
    const hour  = GLib.DateTime.new_now_local().get_hour();
    return hour < 12 ? 'AM' : 'PM';
}

export function date(interval: number) {
    return Variable(GLib.DateTime.new_now_local()).poll(interval, () => GLib.DateTime.new_now_local())
}

export function meridiem() {
    return Variable(getMeridiem()).poll(1000, () => getMeridiem());
}
