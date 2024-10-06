{ config, ... }:
{
  programs.kitty = {
    enable = true;
    shellIntegration = {
      enableZshIntegration = true;
      mode = "no-cursor";
    };
    themeFile = "Catppuccin-Mocha";
    font = {
      name = "SF Mono Medium";
      size = 12.0;
    };

    keybindings = {

      "shift+alt+up" = "move_window up";
      "shift+alt+left" = "move_window left";
      "shift+alt+right" = "move_window right";
      "shift+alt+down" = "move_window down";

      "kitty_mod+left" = "neighboring_window left";
      "kitty_mod+right" = "neighboring_window right";
      "kitty_mod+up" = "neighboring_window up";
      "kitty_mod+down" = "neighboring_window down";

      "alt+t" = "new_tab_with_cwd";
      "alt+v" = "launch --cwd=current --location=vsplit";
      "alt+h" = "launch --cwd=current --location=hsplit";
      "alt+n" = "next_tab";
      "alt+b" = "previous_tab";
      "alt+q" = "close_tab";
      "alt+shift+q" = "close_window";
      "alt+," = "move_tab_backward";
      "alt+." = "move_tab_forward";

      "alt+1" = "goto_tab 1";
      "alt+2" = "goto_tab 2";
      "alt+3" = "goto_tab 3";
      "alt+4" = "goto_tab 4";
      "alt+5" = "goto_tab 5";
      "alt+6" = "goto_tab 6";
      "alt+7" = "goto_tab 7";
      "alt+8" = "goto_tab 8";
      "alt+9" = "goto_tab 9";
        
      # clear the terminal screen
      "alt+k" =
        "combine : clear_terminal scrollback active";

      "kitty_mod+equal" = "change_font_size all +1.0";
      "kitty_mod+minus" = "change_font_size all -1.0";
      "kitty_mod+0" = "change_font_size all 0";
    };

    settings = {
      bold_font = "SF Mono Bold";
      italic_font = "SF Mono Heavy Italic";
      bold_italic_font = "SF Mono Bold Italic";
      cursor_shape = "block";
      cursor_blink_interval = "0";
      tab_bar_edge = "bottom";
      tab_bar_margin_height = "0.0 4.0";
      tab_bar_style = "slant";
      tab_bar_min_tabs = "2";
      tab_title_template = ''"{activity_symbol} {index} {tab.active_exe}"'';
      enable_audio_bell = "no";
      bell_on_tab = "yes";
      enabled_layouts = "*";
      kitty_mod = "ctrl+shift";
      adjust_line_height = "100%";
      disable_ligatures = "cursor";
      window_padding_width = "5";
      window_border_width = "1pt";
      scrollback_pager_history_size = 100;
    };

    extraConfig = ''
      font_features SFMono-Medium +zero +ss01 +ss02 +ss03 +ss04 +ss05 +cv31
      font_features SFMono-Bold +zero +ss01 +ss02 +ss03 +ss04 +ss05 +cv31
      font_features SFMono-HeavyItalic +zero +ss01 +ss02 +ss03 +ss04 +ss05 +cv31
      font_features SFMono-BoldItalic +zero +ss01 +ss02 +ss03 +ss04 +ss05 +cv31
    '';
  };
}
