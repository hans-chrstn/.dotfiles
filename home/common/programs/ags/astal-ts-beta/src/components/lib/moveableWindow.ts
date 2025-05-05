import { GObject } from "astal";
import { astalify, ConstructProps, Gtk } from "astal/gtk3";

export class MoveableWindow extends astalify(Gtk.Window) {
    static { GObject.registerClass(this); }
    constructor(props: any) {
        super(props as any);
    }
}
