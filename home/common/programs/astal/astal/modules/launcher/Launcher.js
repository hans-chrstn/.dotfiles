const { query } = await Service.import('applications')
const WINDOW_NAME = 'applauncher';

const AppItem = app => Widget.Button({
    cssClasses: ['launcher_button'],
    on_clicked: () => {
        App.closeWindow(WINDOW_NAME);
        app.launch();
    },
    attribute: { app },
    child: Widget.Box({
        cssClasses: ['launcher_icon_label_container'],
        children: [
            Widget.Icon({
                cssClasses: ['launcher_icon'],
                icon: app.icon_name || '',
            }),
            Widget.Label({
                cssClasses: ['launcher_title'],
                label: app.name,
                vpack: 'center',
                truncate: 'end',
            }),
        ],
    }),
});

const Applauncher = () => {
    // list of application buttons
    let applications = query('').map(AppItem);

    // container holding the buttons
    const list = Widget.Box({
        vertical: true,
        children: applications,
    });

    // repopulate the box, so the most frequent apps are on top of the list
    function repopulate() {
        applications = query('').map(AppItem);
        list.children = applications;
    }

    // search entry
    const entry = Widget.Entry({
        hexpand: true,
        cssClasses: ['launcher_search'],

        // to launch the first item on Enter
        on_accept: () => {
            if (applications[0]) {
                App.toggleWindow(WINDOW_NAME);
                applications[0].attribute.app.launch();
            }
        },

        // filter out the list
        on_change: ({ text }) => applications.forEach(item => {
            item.visible = item.attribute.app.match(text);
        }),
    });

    return Widget.Box({
        vertical: true,
        cssClasses: ['launcher_box'],
        
        children: [
            entry,

            // wrap the list in a scrollable
            Widget.Scrollable({
                hscroll: 'never',
                cssClasses: ['launcher_list'],
                child: list,
            }),
        ],
        setup: self => self.hook(App, (_, windowName, visible) => {
            if (windowName !== WINDOW_NAME)
                return;

            // when the applauncher shows up
            if (visible) {
                repopulate();
                entry.text = '';
                entry.grab_focus();
            }
        }),
    });
};

// there needs to be only one instance
export default () => Widget.Window({
    name: WINDOW_NAME,
    visible: false,
    keymode: 'on-demand',
    child: Applauncher()
});
