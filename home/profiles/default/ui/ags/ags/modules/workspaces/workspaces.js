import { Widget, Utils, Hyprland } from '../../utils/imports.js';

export default () => Widget.EventBox({
    on_hover: (box) => {
        box.child.children[1].reveal_child = true
    },
    on_hover_lost: (box) => {
        box.child.children[1].reveal_child = false
    },
    class_name: 'workspaces',
    child: Widget.Box({
        children: [
            Widget.Icon({
                class_name: 'static_cat',
                icon: `${App.configDir}/assets/static_cat.png`,
                size: 38,
            }),
            Widget.Revealer({
                reveal_child: false,
                transition: 'slide_left',
                transitionDuration: 1000,
                child: 
                    Workspaces()
            }),
        ],
    })
});

function toJapaneseNumeral(number) {
    const numerals = ['一', '二', '三', '四', '五', '六', '七', '八', '九', '十'];
    return numerals[number-1] || number.toString();
}

const WorkspaceButton = (i) => Widget.Button({
    class_name: 'ws_button',
    on_primary_click_release: () => 
        Hyprland.messageAsync(`dispatch workspace ${i}`)
            .catch(logError),
    child: Widget.Label({
        label: toJapaneseNumeral(i),
        class_name: 'ws_button_label'
    })
})
    .hook(Hyprland.active.workspace, (button) => {
      button.toggleClassName("active", Hyprland.active.workspace.id === i);
    });

const Workspaces = () => Widget.EventBox({
  child: Widget.Box({
    class_name: "ws_container",
    children: Array.from({length: 10}, (_, i) => i + 1).map(i => WorkspaceButton(i)),
  })
    .hook(Hyprland, (box) => {
      box.children.forEach((button, i) => {
        const ws = Hyprland.getWorkspace(i + 1);
        const ws_before = Hyprland.getWorkspace(i);
        const ws_after = Hyprland.getWorkspace(i + 2);
        //toggleClassName is not part od Gtk.Widget, but we know box.children only includes AgsWidgets
        //@ts-ignore
        button.toggleClassName("occupied", ws?.windows > 0);
        //@ts-ignore
        button.toggleClassName("occupied-left", !ws_before || ws_before?.windows <= 0);
        //@ts-ignore
        button.toggleClassName("occupied-right", !ws_after || ws_after?.windows <= 0);
      });
    }, "notify::workspaces")
});
