{ config, pkgs, ... }:

let
  displayFullscreenStatusScript = pkgs.pkgs.writeShellScriptBin "display-fullscreen-status"
    '' hyprctl activewindow | grep -q "fullscreen: 1" && echo "Fullscreen: ON ⛶" '';
  wireguardManagerRofiRasi = pkgs.pkgs.writeText "wireguard-manager-rofi.rasi"
    ''
      * {
        border: none;
        border-radius: 0;
        /* font: Roboto,'Font Awesome 5', 'SFNS Display',  Helvetica, Arial, sans-serif; */
        font-size: 15px;
        min-height: 0;
        background-color: #282a36;
        color: #f8f8f2;
      }

      #window {
        width: 300px;
        padding: 15px;

        border: 2px;
        border-color: #44475a;
      }

      #entry {
        expand: true;
        width: 200px;
      }
    '';
  wireguardManagerScript = pkgs.pkgs.writeShellScriptBin "wireguard-manager"
    ''
      #!/usr/bin/env bash

      SERVICE_NAME="wg-quick-wg0.service"
      STATUS_CONNECTED_STR='{"text":"Connected","class":"connected","alt":"connected"}'
      STATUS_DISCONNECTED_STR='{"text":"Disconnected","class":"disconnected","alt":"disconnected"}'

      function askpass() {
        rofi -dmenu -password -no-fixed-num-lines -p "Sudo password : " -theme ${wireguardManagerRofiRasi}
      }

      function status_wireguard() {
        systemctl is-active $SERVICE_NAME >/dev/null 2>&1
        return $?
      }

      function toggle_wireguard() {
        status_wireguard && \
           SUDO_ASKPASS=$0 sudo -A systemctl stop $SERVICE_NAME || \
           SUDO_ASKPASS=$0 sudo -A systemctl start $SERVICE_NAME
      }

      case $1 in
        -s | --status)
          status_wireguard && echo $STATUS_CONNECTED_STR || echo $STATUS_DISCONNECTED_STR
          ;;
        -t | --toggle)
          toggle_wireguard
          ;;
        *)
          askpass
          ;;
      esac
    '';
in
{
  programs.waybar = {
    enable = true;

    style = ./style.css;

    settings = {
      mainBar = {
        "layer" = "top";
        position = "top";
        margin = "10px 10px 0px 10px";
        modules-left = [
          "custom/fullscreen-indicator"
          "hyprland/workspaces"
          "battery"
          "cpu"
          "temperature"
          "memory"
          "network"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "tray"
          "custom/wireguard-manager"
          "backlight"
          "pulseaudio"
          "custom/notification"
          "hyprland/language"
          "custom/power"
        ];
        "hyprland/language" = {
          format = "{short}";
        };
        tray = {
          # "icon-size": 21,
          spacing = 10;
        };
        clock = {
          format = "{:%H:%M - %d.%m.%y}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
            actions = {
              on-click-right = "mode";
              on-click-forward = "tz_up";
              on-click-backward = "tz_down";
              on-scroll-up = "shift_up";
              on-scroll-down = "shift_down";
            };
          };
        };
        temperature = {
          interval = 1;
        };
        cpu = {
          format = "{usage}% ";
          interval = 1;
        };
        memory = {
          format = "{}% ";
          interval = 1;
        };
        battery = {
          bat = "BAT0";
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-icons = [ "" "" "" "" "" ];
        };
        network = {
          interval = 5;
          tooltip-format-wifi = "{essid} ({signalStrength}%) ";
          format-wifi = "{bandwidthDownBytes} ↓   {bandwidthUpBytes} ↑   ({signalStrength}%) ";
          format-ethernet = "{ifname}: {ipaddr}/{cidr} ";
          format-disconnected = "Disconnected ⚠";
        };
        pulseaudio = {
          #"scroll-step": 1,
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon}";
          format-muted = "";
          format-icons = {
            headphones = "";
            handsfree = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" ];
          };
          on-click = "pavucontrol";
        };
        "custom/wireguard-manager" = {
          exec = ''${wireguardManagerScript}/bin/wireguard-manager -s'';
          format = "{icon}";
          format-icons = {
            connected = "<span color=\"#38b057\">VPN: ON</span>";
            disconnected = "<span>VPN: OFF</span>";
          };
          interval = "once";
          on-click = ''${wireguardManagerScript}/bin/wireguard-manager -t && pkill -SIGRTMIN+1 waybar'';
          return-type = "json";
          signal = 1;
        };
        "custom/fullscreen-indicator" = {
          exec = ''${displayFullscreenStatusScript}/bin/display-fullscreen-status'';
          interval = 1;
        };
        "custom/power" = {
          on-click = "wlogout";
          format = "";
        };
        backlight = {
          format = "{percent}% {icon}";
          format-icons = [ "" ];
          scroll-step = 5;
        };
        "custom/notification" = {
          tooltip = false;
          format = "{icon}";
          format-icons = {
            notification = "<span foreground='red'><sup></sup></span>";
            none = "";
            dnd-notification = "<span foreground='red'><sup></sup></span>";
            dnd-none = "";
            inhibited-notification = "<span foreground='red'><sup></sup></span>";
            inhibited-none = "";
            dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
            dnd-inhibited-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };
      };
    };
  };
}
