{ config, pkgs, nixvim, ... }:

let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    swww init &
    swww img ~/Wallpapers/1.jpg &
    swww img ~/Wallpapers/2.jpg &
    swww img ~/Wallpapers/3.png &
    swww img ~/Wallpapers/4.png &
    swww img ~/Wallpapers/5.jpg &
    swww img ~/Wallpapers/6.png &
    swww img ~/Wallpapers/7.jpg &
    swww img ~/Wallpapers/8.jpg &

    waybar &

    swaync
  '';
in
{

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ",highres,auto,1";

      xwayland = {
        force_zero_scaling = true;
      };

      env = [ "GDK_SCALE, 1" "XCURSOR_SIZE, 32" ];

      input = {
        kb_layout = "us, ru";
        kb_variant = "";
        kb_model = "";
        kb_options = "grp:alt_shift_toggle, compose:ralt";
        kb_rules = "";

        follow_mouse = 1;

        touchpad = {
          natural_scroll = "yes";
        };

        sensitivity = 0;
      };

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        layout = "dwindle";
        allow_tearing = false;
      };

      decoration = {
        rounding = 10;

        blur = {
          enabled = true;
          size = 4;
          passes = 4;
          ignore_opacity = true;
        };

        drop_shadow = "yes";
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      windowrulev2 = "opacity 0.9 0.9, class:^(kitty)$";

      layerrule = [
        "blur, wofi"
        "ignorealpha 0.1, wofi"
        "blur, waybar"
        "ignorealpha 0.1, waybar"
        "blur, swaync"
        "ignorealpha 0.1, swaync"
        "blur, wlogout"
        "blur, logout_dialog"
      ];

      animations = {
        enabled = "yes";

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      master.new_is_master = true;

      gestures.workspace_swipe = "off";

      misc.force_default_wallpaper = -1;

      "$mainMod" = "SUPER";

      bind = [

        "$mainMod, O, exec, obsidian"
        "$mainMod, T, exec, kitty"
        "$mainMod, B, exec, microsoft-edge-dev "
        "$mainMod, Q, killactive, "
        "$mainMod, M, exec, wlogout "
        "$mainMod SHIFT, L, exec, hyprlock "
        "$mainMod SHIFT, V, togglefloating, "
        "$mainMod, P, pseudo, " # dwindle
        "$mainMod, S, togglesplit, " # dwindle

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Move focus with mainMod + hjkl
        "$mainMod, H, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Example special workspace (scratchpad)
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # fullscreen
        "$mainMod, F, fullscreen, 1"
        "$mainMod CONTROL, F, fakefullscreen"
        "$mainMod SHIFT, F, fullscreen,"

        # open the wofi launcher
        "SUPER, SUPER_L, exec, if ! pidof -s wofi > /dev/null; then wofi --show=drun --allow-images -i; fi"

        # switch between windows
        "ALT, Tab, cyclenext,"
        "ALT, Tab, bringactivetotop,"

        # screenshot
        ", Print, exec, hyprshot -m region"

        # FN mute
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

        # display cliphist in wofi
        "$mainMod, V, exec, if ! pidof -s wofi > /dev/null; then cliphist list | wofi --dmenu | cliphist decode | wl-copy; fi"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      binde = [
        # keyboard backlight
        ", XF86MonBrightnessUp, exec, brightnessctl set +20%"
        ", XF86MonBrightnessDown, exec, brightnessctl set 20%-"

        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
      ];

      exec-once = [
        ''${startupScript}/bin/start''
        #"bash ~/.config/hypr/start.sh"
        "lxsession"
        "nm-applet --indicator"

        # persists clopboard on program close
        "wl-clip-persist --clipboard regular"

        # listen for keyboard changes
        "wl-paste --type text --watch cliphist store" #Stores only text data
        "wl-paste --type image --watch cliphist store" #Stores only image data
      ];
    };
  };

}
