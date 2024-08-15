{ ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
      };
      "$accent" = "rgba(110, 108, 126, 1.0)";
      "$accentAlpha" = "cba6f7";
      "$font" = "SF Mono";
      "$base" = "0xff1e1e2e";
      "$textAlpha" = "cdd6f4";
      "$skyAlpha" = "89dceb";
      "$text" = "0xffcdd6f4";
      "$surface0" = "0xff313244";
      "$red" = "0xfff38ba8";
      "$yellow" = "0xfff9e2af";
      background = [
        {
          monitor = "eDP-1";
          path = "~/.wallpapers/catppuccin.png";
          blur_passes = 0;
          color = "$base";
        }
        {
          monitor = "HDMI-A-1";
          path = "~/.wallpapers/catppuccin2.png";
          blur_passes = 0;
          color = "$base";
        }
        {
          monitor = "HDMI-A-2";
          path = "~/.wallpapers/catppuccin2.png";
          blur_passes = 0;
          color = "$base";
        }
      ];

      image = {
        monitor = "";
        path = "$HOME/.wallpapers/pfp.png";
        size = 100;
        border_color = "$accent";
        position = "0, 75";
        halign = "center";
        valign = "center";
      };
      label = [
        {
          monitor = "";
          text = "$TIME";
          color = "$text";
          font_size = 60;
          font_family = "$font";
          position = "-30, 0";
          halign = "right";
          valign = "top";
        }
        {
          monitor = ""; 
          text = ''cmd[update:43200000] echo "$(date +"%A, %d %B %Y")"'';
          color = "$text";
          font_size = 15;
          font_family = "$font";
          position = "-30, -90";
          halign = "right";
        }
        {
          monitor = "";
          text = "cmd[update:150000] echo \"<span foreground='##$textAlpha'>$(playerctl metadata --format '{{title}}   {{artist}}')</span>\"";
          color = "$text";
          font_size = 8;
          font_family = "JetBrainsMono, Font Awesome 6 Free Solid";
          position = "10, -35";
          halign = "left";
          valign = "bottom";
        }
      ];
      input-field = {
        monitor = "";
        size = "300, 60";
        outline_thickness = 4;
        dots_size = "0.2";
        dots_spacing = "0.2";
        dots_center = true;
        outer_color = "$accent";
        inner_color = "$surface0";
        font_color = "$text";
        fade_on_empty = false;
        placeholder_text = "<span foreground='##$textAlpha'><i>󰌾 Logged in as </i><span foreground='##$skyAlpha'><i><b>$USER</b></i></span></span>";
        hide_input = false;
        check_color = "$accent";
        fail_color = "$red";
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
        capslock_color = "$yellow";
        position = "0, -35";
        halign = "center";
        valign = "center";
      };
    };
  };
}
