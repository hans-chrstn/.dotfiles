import { Gtk } from "astal/gtk3";
import AstalCava from "gi://AstalCava?version=0.1";

const cava = AstalCava.get_default();

export function RoundCorner ({
    anchor,
    className = `roundcorner-${anchor}`,
    visibility = true,
    sizeX = 30,
    sizeY = 30,
}: {
    anchor: 'topleft' | 'topright' | 'bottomleft' | 'bottomright';
    className?: string;
    visibility?: boolean;
    sizeX?: number;
    sizeY?: number;
}) {
    return (
        <drawingarea
            visible={visibility}
            className={className}
            setup={(self) => {
                self.set_size_request(sizeX, sizeY);
            }}
            onDraw={(self, cr) => {
                const context = self.get_style_context();
                const c = context.get_property("background-color", Gtk.StateFlags.NORMAL);
                const r = context.get_property("border-radius", Gtk.StateFlags.NORMAL);

                switch (anchor) {
                    case "topleft":
                        cr.arc(2, r, r, 3 * Math.PI / 2, 2 * Math.PI);
                        cr.lineTo(r, 0);
                        break;
                    case "topright":
                        cr.arc(r - 2, r, r, Math.PI, 3 * Math.PI / 2);
                        cr.lineTo(0, 0);
                        break;
                    case "bottomleft":
                        cr.arc(2, 0, r, Math.PI / 2, Math.PI);
                        cr.lineTo(r, r);
break;
                    case "bottomright":
                        cr.arc(r - 2, 0, r, 0, Math.PI / 2);
                        cr.lineTo(0, r);
                        break;
                }
                cr.closePath();
                cr.setSourceRGBA(c.red, c.green, c.blue, c.alpha);
                cr.fill();
            }}
        />
    )
}

export function CavaWidget({
    className = "cava",
    sizeX = 50,
    sizeY = 50,
}: {
    className?: string;
    sizeX: number;
    sizeY: number;
}) {
    return (
        <drawingarea
            className={className}
            setup={(self) => {
                self.set_size_request(sizeX, sizeY); // Initial size
                self?.hook(cava, "notify::values", () => {
                    self.queue_draw();
                })
            }}
            onDraw={(self, cr) => {
                const h = self.get_allocated_height();
                const w = self.get_allocated_width();
                const bars = cava.get_bars();
                
                Gtk.render_background(self.get_style_context(), cr, 0, 0, w, h);
                const fg = self.get_style_context().get_property("color", Gtk.StateFlags.NORMAL);
                cr.setSourceRGBA(fg.red, fg.green, fg.blue, fg.alpha);

                let lastX = 0;
                let lastY = h - h * (cava.get_values()[0]);
                cr.moveTo(lastX, lastY);
                for (let i = 1; i < cava.get_values().length; i++) {
                  const height = h * (cava.get_values()[i]);
                  let y = h - height;
                  cr.curveTo(lastX + w / (bars - 1) / 2, lastY, lastX + w / (bars - 1) / 2, y, i * (w / (bars - 1)), y);
                  lastX = i * (w / (bars - 1));
                  lastY = y;
                }
                cr.lineTo(w, h);
                cr.lineTo(0, h);
                cr.fill();
            }}
        />
    )
}
