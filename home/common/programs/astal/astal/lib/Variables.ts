import Glib from 'types/@girs/glib-2.0/glib-2.0';
export function clock(interval: number) {
  return Variable(Glib.DateTime.new_now_local(), {
    poll: [interval, () => Glib.DateTime.new_now_local()],
  }); 
}
