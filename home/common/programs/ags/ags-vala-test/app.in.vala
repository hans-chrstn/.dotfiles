class App : Astal.Application {
    public static App instance;
    public string configDir = "@CONFIG_DIR@";

    private static void on_css_changed(string path, FileMonitorEvent event_type) {
      if (event_type == FileMonitorEvent.CHANGES_DONE_HINT) {
        print ("CSS Changed: %s\n", path);
        apply_css("@STYLE@", true);
      }
    }

    public override void request (string msg, SocketConnection conn) {
        print(@"$msg\n");
        AstalIO.write_sock.begin(conn, "ok");
    }

    public override void activate () {
        foreach (var mon in this.monitors) {
            add_window(new Background(mon));
            add_window(new AppLauncher(mon));
        }
        try {
          string stylesDir = configDir + "/styles/";
          
          AstalIO.monitor_file(stylesDir, (path, event_type) => on_css_changed(path, event_type));

        } catch (Error err) {
          print("Issue with CSS: %s\n", err.message);
        }
    }

    public static void main(string[] args) {
        var instance_name = "vala";

        App.instance = new App() {
            instance_name = instance_name
        };

        try {
            App.instance.acquire_socket();
            App.instance.run(null);
        } catch (Error err) {
            print(AstalIO.send_message(instance_name, string.joinv(" ", args)));
        }
    }
}
