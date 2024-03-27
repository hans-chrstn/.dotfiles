import Glib from 'gi://GLib';
import { Widget } from '../utils/imports.js';

const currentTime = Glib.DateTime.new_now_local();

export default ({
    format = '%H:%M:%S %B %e, %A',
    interval = 1000,
    class_name = 'icon',
    ...rest } = {}) => Widget.EventBox({
        on_hover: (box) => {
            box.child.children[1].reveal_child = true
        },
        on_hover_lost: (box) => {
            box.child.children[1].reveal_child = false
        },
        child: Widget.Box({
            children: [
                Widget.Label({
                    class_name: `${class_name}`,
                    ...rest,
                    setup: self => self.poll(interval, () => {
                        const formattedTime = currentTime.format(format) || 'wrong format';
                        self.label = `${formattedTime}`;
                    })
                }),
                Widget.Revealer({
                    reveal_child: false,
                    transition: 'slide_left',
                    transitionDuration: 1000,
                    child: Widget.Label({
                        setup: self => self.poll(interval, () => {
                            const[hour, min] = [currentTime.get_hour(), currentTime.get_minute()];
                            const timeOfDay = getTimeOfDay(hour, min);
                            self.label = `| ${timeOfDay}`;
                        })
                    })
                }),
            ],
        })
    });

// Function to determine the time of day
function getTimeOfDay(hour, min) {
    if (hour >= 1 && hour < 5) {
        return 'Dawn';
    } else if (hour === 5 && min < 30) {
        return 'Morning';
    } else if (hour >= 7 && hour < 11) {
        return 'Early Morning';
    } else if (hour >= 11 && hour < 12) {
        return 'Late Morning';
    } else if (hour === 12 && min <= 29) {
        return 'Midday';
    } else if (hour === 12 && min >= 30) {
        return 'Afternoon';
    } else if (hour >= 13 && hour < 16) {
        return 'Early Afternoon';
    } else if (hour === 16 && min <= 59) {
        return 'Late Afternoon';
    } else if (hour >= 17 && hour < 19) {
        return 'Evening';
    } else if (hour >= 19 && hour < 21) {
        return 'Early Evening';
    } else if (hour >= 21 && hour <= 23) {
        return 'Late Evening';
    } else if (hour === 0 && min <= 59) {
        return 'Midnight';
    } else {
        return 'N/A';
    }
}
