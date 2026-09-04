{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        exclusive = false;
        passthrough = false;
        # height = 38;
        margin-top = 8;
        margin-left = 14;
        margin-right = 14;
        spacing = 8;

        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "pulseaudio"
          "bluetooth"
          "network"
          "cpu"
          "memory"
          "battery"
          "custom/language"
        ];

        "hyprland/workspaces" = {
          disable-scroll = false;
          all-outputs = true;
          active-only = false;
          format = "{name}";
          on-click = "activate";
        };

        "hyprland/window" = {
          format = "{}";
          max-length = 35;
          separate-outputs = true;
        };

        "clock" = {
          interval = 1;
          format = "󰸗 {0:%a, %b %d}  •  󱑂 {0:%H:%M}";
          format-alt = "󱑂 {0:%H:%M:%S}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = "󰝟 消音";
          format-icons = {
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
          };
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-click-right = "pavucontrol";
        };

        "bluetooth" = {
          format = "󰂯";
          format-disabled = "󰂲";
          format-connected = "󰂱 {device_alias}";
          format-connected-battery = "󰂱 {device_alias} ({device_battery_percentage}%)";
          tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          on-click = "blueman-manager";
        };

        "network" = {
          format-wifi = "󰖩 {essid}";
          format-ethernet = "󰈀 {ipaddr}";
          format-disconnected = "󰖪 圏外";
          tooltip-format = "{ifname} via {gwaddr}";
        };

        "cpu" = {
          interval = 3;
          format = "󰍛 {usage}%";
          states = {
            warning = 70;
            critical = 90;
          };
        };

        "memory" = {
          interval = 5;
          format = "󰘚 {}%";
          states = {
            warning = 75;
            critical = 90;
          };
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 20;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󰂄 {capacity}%";
          format-icons = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
        };

        "custom/language" = {
          exec = "case $(fcitx5-remote -n 2>/dev/null) in mozc) echo 'JP' ;; keyboard-th) echo 'TH' ;; *) echo 'EN' ;; esac";
          interval = 1;
          format = "󰌌 {}";
          on-click = "fcitx5-remote -t";
          tooltip = false;
        };
      };
    };

    style = ''
      @define-color yozakura_bg      rgba(26, 21, 27, 0.88);
      @define-color sakura_border    rgba(254, 223, 225, 0.22);
      @define-color usuzakura        #fdeff2;
      @define-color nadeshiko        #f5a3b7;
      @define-color benizakura       #d05a7e;
      @define-color fukaki_beni      #b83b5e;
      @define-color kareha_sakura    #664855;
      @define-color ink_dark         #1a151b;

      * {
        border: none;
        font-family: "JetBrainsMono Nerd Font", sans-serif;
        font-size: 13px;
        font-weight: bold;
        min-height: 0;
      }

      window#waybar {
        background: transparent;
      }

      .modules-left,
      .modules-center,
      .modules-right {
        background: @yozakura_bg;
        border: 1px solid @sakura_border;
        border-radius: 14px;
        padding: 4px 12px;
      }

      #workspaces {
        padding: 0;
      }

      #workspaces button {
        padding: 2px 9px;
        margin: 1px 2px;
        border-radius: 9px;
        background: transparent;
        transition: all 0.25s ease-in-out;
      }

      #workspaces button:nth-child(1) { color: #b84e6f; }
      #workspaces button:nth-child(2) { color: #cf6684; }
      #workspaces button:nth-child(3) { color: #e17c98; }
      #workspaces button:nth-child(4) { color: #f095ac; }
      #workspaces button:nth-child(5) { color: #f7aabf; }
      #workspaces button:nth-child(6) { color: #fbc0cf; }
      #workspaces button:nth-child(n+7) { color: #fedfe1; }

      #workspaces button:hover {
        background: rgba(254, 223, 225, 0.15);
        color: @usuzakura;
      }

      #workspaces button.active {
        background: @nadeshiko;
        color: @ink_dark;
      }

      #workspaces button.urgent {
        background: @benizakura;
        color: @usuzakura;
      }

      #window {
        color: @usuzakura;
        padding-left: 10px;
        margin-left: 8px;
        border-left: 1px solid @sakura_border;
      }

      #clock {
        color: @usuzakura;
        padding: 0 4px;
      }

      #pulseaudio,
      #bluetooth,
      #network,
      #cpu,
      #memory,
      #battery,
      #custom-language {
        color: @usuzakura;
        padding: 0 7px;
        margin: 0 1px;
      }

      #pulseaudio.muted,
      #bluetooth.disabled,
      #bluetooth.off,
      #network.disconnected {
        color: @kareha_sakura;
      }

      #cpu.warning,
      #memory.warning,
      #battery.warning:not(.charging) {
        color: @benizakura;
      }

      #cpu.critical,
      #memory.critical {
        color: @fukaki_beni;
      }

      #battery.critical:not(.charging) {
        background-color: @fukaki_beni;
        color: @usuzakura;
        border-radius: 8px;
        padding: 2px 8px;
      }

      #custom-language {
        color: @usuzakura;
        background: rgba(254, 223, 225, 0.08);
        border: 1px solid rgba(254, 223, 225, 0.12);
        border-radius: 8px;
        padding: 2px 7px;
        margin-left: 4px;
      }
    '';
  };
}
