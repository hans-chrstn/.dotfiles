{ lib, config, ... }:
let
 cfg = config.mod.programs.btop;
in 
{
  options.mod.programs.btop = {
    enable = lib.mkEnableOption "Enable btop";
    enableCustomTheme = lib.mkEnableOption "Enable btop custom theme";
    enableCustomSettings = lib.mkEnableOption "Enable btop custom settings";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge
    [
      {
        programs.btop.enable = true;
      }

      (lib.mkIf (cfg.enableCustomTheme) {
        programs.btop.settings = {
          color_theme = "catpuccin_mocha";
        };
        programs.btop.themes.catpuccin_mocha = ''
          theme[main_bg]="#1E1E2E"

          theme[main_fg]="#CDD6F4"

          theme[title]="#CDD6F4"

          theme[hi_fg]="#89B4FA"

          theme[selected_bg]="#45475A"

          theme[selected_fg]="#89B4FA"

          theme[inactive_fg]="#7F849C"

          theme[graph_text]="#F5E0DC"

          theme[meter_bg]="#45475A"

          theme[proc_misc]="#F5E0DC"

          theme[cpu_box]="#cba6f7" #Mauve
          theme[mem_box]="#a6e3a1" #Green
          theme[net_box]="#eba0ac" #Maroon
          theme[proc_box]="#89b4fa" #Blue

          theme[div_line]="#6C7086"

          theme[temp_start]="#a6e3a1"
          theme[temp_mid]="#f9e2af"
          theme[temp_end]="#f38ba8"

          theme[cpu_start]="#94e2d5"
          theme[cpu_mid]="#74c7ec"
          theme[cpu_end]="#b4befe"

          theme[free_start]="#cba6f7"
          theme[free_mid]="#b4befe"
          theme[free_end]="#89b4fa"

          theme[cached_start]="#74c7ec"
          theme[cached_mid]="#89b4fa"
          theme[cached_end]="#b4befe"

          theme[available_start]="#fab387"
          theme[available_mid]="#eba0ac"
          theme[available_end]="#f38ba8"

          theme[used_start]="#a6e3a1"
          theme[used_mid]="#94e2d5"
          theme[used_end]="#89dceb"

          theme[download_start]="#fab387"
          theme[download_mid]="#eba0ac"
          theme[download_end]="#f38ba8"

          theme[upload_start]="#a6e3a1"
          theme[upload_mid]="#94e2d5"
          theme[upload_end]="#89dceb"

          theme[process_start]="#74C7EC"
          theme[process_mid]="#89DCEB"
          theme[process_end]="#cba6f7"
        '';
      })

      (lib.mkIf (cfg.enableCustomSettings) {
        programs.btop.settings = {
          theme_background = true;
          truecolor = true;
          force_tty = false;
          presets = "cpu:1:default,proc:0:default cpu:0:default,mem:0:default,net:0:default cpu:0:block,net:0:tty";
          vim_keys = true;
          rounded_corners = true;
          graph_symbol = "braille";
          graph_symbol_cpu = "default";
          graph_symbol_gpu = "default";
          graph_symbol_mem = "default";
          graph_symbol_net = "default";
          graph_symbol_proc = "default";
          shown_boxes = "cpu mem net proc";
          update_ms = 2000;
          proc_sorting = "cpu lazy";
          proc_reversed = false;
          proc_tree = false;
          proc_colors = true;
          proc_gradient = true;
          proc_per_core = false;
          proc_mem_bytes = true;
          proc_cpu_graphs = true;
          proc_info_smaps = false;
          proc_left = false;
          proc_filter_kernel = false;
          proc_aggregate = false;
          cpu_graph_upper = "Auto";
          cpu_graph_lower = "Auto";
          show_gpu_info = "Auto";
          cpu_invert_lower = true;
          cpu_single_graph = false;
          cpu_bottom = false;
          show_uptime = true;
          check_temp = true;
          cpu_sensor = "Auto";
          show_coretemp = true;
          cpu_core_map = "";
          temp_scale = "celsius";
          base_10_sizes = false;
          show_cpu_freq = true;
          clock_format = "%X";
          background_update = true;
          custom_cpu_name = "";
          disks_filter = "";
          mem_graphs = true;
          mem_below_net = false;
          zfs_arc_cached = true;
          show_swap = true;
          swap_disk = true;
          show_disks = true;
          only_physical = true;
          use_fstab = true;
          zfs_hide_datasets = false;
          disk_free_priv = false;
          show_io_stat = true;
          io_mode = false;
          io_graph_combined = false;
          io_graph_speeds = "";
          net_download = 100;
          net_upload = 100;
          net_auto = true;
          net_sync = true;
          net_iface = "";
          show_battery = true;
          selected_battery = "Auto";
          show_battery_watts = true;
          log_level = "WARNING";
          nvml_measure_pcie_speeds = true;
          gpu_mirror_graph = true;
          custom_gpu_name0 = "";
          custom_gpu_name1 = "";
          custom_gpu_name2 = "";
          custom_gpu_name3 = "";
          custom_gpu_name4 = "";
          custom_gpu_name5 = "";
        };
      })
    ]
  );
}
