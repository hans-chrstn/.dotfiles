import { Notifications } from "imports";

export function NotificationPopups(monitor) {
    const list = Widget.Box({
        vertical: true,
        children: Notifications.popups.map(Notification),
    })

    function onNotified(_, /** @type {number} */ id) {
        const n = Notifications.getNotification(id)
        if (n)
            list.children = [Notification(n), ...list.children]
    }

    function onDismissed(_, /** @type {number} */ id) {
        list.children.find(n => n.attribute.id === id)?.destroy()
    }

    list.hook(Notifications, onNotified, "notified")
        .hook(Notifications, onDismissed, "dismissed")

    return Widget.Window({
        monitor,
        name: `notifications-${monitor}`,
        class_name: "notification-popups",
        anchor: ["top", "right"],
        child: Widget.Box({
            css: "min-width: 2px; min-height: 2px;",
            class_name: "notifications",
            vertical: true,
            child: list,

            /** this is a simple one liner that could be used instead of
                hooking into the 'notified' and 'dismissed' signals.
                but its not very optimized becuase it will recreate
                the whole list everytime a notification is added or dismissed */
            // children: notifications.bind('popups')
            //     .as(popups => popups.map(Notification))
        }),
    })
}
