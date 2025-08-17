import { GObject } from "astal";
import { astalify, ConstructProps, Gtk } from "astal/gtk3";

export class FileChooserButton extends astalify(Gtk.FileChooserButton) {
    static { GObject.registerClass(this); }
    constructor(props: ConstructProps<
        FileChooserButton,
        Gtk.FileChooserButton.ConstructorProps,
        { onFileSet: []}
    >) {
        super(props as any);
    }
}
