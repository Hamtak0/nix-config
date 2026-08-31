{
  lib,
  ...
}:
let
  mod = "SUPER";
  term = "foot";

  lua = lib.generators.mkLuaInline;

  dsp = {
    exec = cmd: lua ''hl.dsp.exec_cmd("${cmd}")'';
    close = lua "hl.dsp.window.close()";
    exit = lua "hl.dsp.exit()";
    layout = msg: lua ''hl.dsp.layout("${msg}")'';
    focus = dir: lua ''hl.dsp.focus({ direction = "${dir}" })'';
    swap = dir: lua ''hl.dsp.window.swap({ direction = "${dir}" })'';
    focusWorkspace = ws: lua ''hl.dsp.focus({ workspace = "${toString ws}" })'';
    moveToWorkspace = ws: lua ''hl.dsp.window.move({ workspace = "${toString ws}" })'';
    sendShortcut = cont: key: lua ''hl.dsp.send_shortcut({ mods = "${cont}", key = "${key}" })'';
  };

  bind = keys: dispatcher: {
    _args = [
      keys
      dispatcher
    ];
  };
  bindOpts = keys: dispatcher: opts: {
    _args = [
      keys
      dispatcher
      opts
    ];
  };

in
{
  nix.settings = {
    extra-substituters = [ "https://hyprland.cachix.org" ];
    extra-trusted-substituters = [ "https://hyprland.cachix.org" ];
    extra-trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    package = null;
    portalPackage = null;
    systemd.enable = false;
    settings = {
      monitor = [
        {
          output = "desc:Chimei Innolux Corporation 0x1521";
          mode = "preferred";
          position = "0x0";
          scale = "1";
        }
        {
          output = "HDMI-A-1";
          mode = "highres";
          position = "auto";
          scale = "1";
        }
        {
          output = "";
          mode = "preferred";
          position = "auto";
          scale = "1";
        }
      ];

      config = {
        input = {
          kb_layout = "us"; # th, jp
          # kb_options = "grp:win_space_toggle";
          numlock_by_default = true;
          repeat_rate = 40;
          repeat_delay = 275;
          follow_mouse = 1;
          sensitivity = 0;
          accel_profile = "flat";
          touchpad.natural_scroll = true;
        };

        general = {
          gaps_in = 1;
          gaps_out = 0;
          border_size = 0;
          layout = "scrolling";
          allow_tearing = true;
        };

        scrolling = {
          fullscreen_on_one_column = false;
          column_width = 1;
          focus_fit_method = 1;
        };

        decoration = {
          rounding = 8;
          active_opacity = 1.0;
          inactive_opacity = 0.96;
          blur = {
            enabled = true;
            size = 2;
            passes = 2;
            special = false;
          };
          shadow.enabled = false;
          dim_special = 0.5;
        };

        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
        };
      };

      animation = [
        {
          leaf = "windowsIn";
          enabled = 1;
          speed = 3;
          spring = "default";
          style = "popin 50%";
        }
        {
          leaf = "windowsOut";
          enabled = 1;
          speed = 4;
          spring = "default";
          style = "popin 75%";
        }
        {
          leaf = "windowsMove";
          enabled = 1;
          speed = 3;
          spring = "default";
        }
        {
          leaf = "border";
          enabled = 1;
          speed = 10;
          spring = "default";
        }
        {
          leaf = "borderangle";
          enabled = 1;
          speed = 7.5;
          spring = "default";
        }
        {
          leaf = "fade";
          enabled = 1;
          speed = 7;
          spring = "default";
        }
        {
          leaf = "workspaces";
          enabled = 1;
          speed = 3;
          spring = "default";
          style = "slidefadevert 10%";
        }
        {
          leaf = "specialWorkspace";
          enabled = 1;
          speed = 4;
          spring = "default";
          style = "slidefadevert 5%";
        }
        {
          leaf = "layers";
          enabled = 1;
          speed = 2.5;
          spring = "default";
          style = "fade";
        }
        {
          leaf = "fadeLayers";
          enabled = 1;
          speed = 2.5;
          spring = "default";
        }
      ];

      # See https://wiki.hypr.land/Configuring/Window-Rules/ for more
      # See https://wiki.hypr.land/Configuring/Workspace-Rules/ for workspace rules

      gesture =
        # let
        #   dspFn = {
        #     layout = msg: lua ''function() hl.dsp.layout("${msg}") end'';
        #     focusWorkspace = ws: lua ''function() hl.dsp.focus({ workspace = "${toString ws}"}) end'';
        #   };
        # in
        [
          # finger, direction, action
          #! It cannot accept the action function somehow
          # {
          #   fingers = 3;
          #   direction = "right";
          #   action = dspFn.layout "move -col";
          # }
          # {
          #   fingers = 3;
          #   direction = "left";
          #   action = dspFn.layout "move +col";
          # }
          {
            fingers = 3;
            direction = "horizontal";
            action = "scroll_move";
          }
          {
            fingers = 4;
            direction = "vertical";
            action = "workspace";
          }
        ];

      window_rule = [
        # Ignore maximize requests from apps. You'll probably like this.
        {
          match = {
            class = ".*";
          };
          suppress_event = "maximize";
        }

        # Fix some dragging issues with XWayland
        {
          match = {
            class = "^$";
            title = "^$";
            xwayland = true;
            float = true;
            fullscreen = false;
            pin = false;
          };
          no_focus = true;
        }
      ];

      bind = [
        # Basic usage
        (bind "${mod} + W" dsp.close)
        (bind "${mod} + SHIFT + W" dsp.exit)
        (bind "${mod} + L" (dsp.exec "uwsm-app -- hyprlock"))
        (bind "${mod} + R" (dsp.exec "uwsm-app -- rofi -show drun -show-icons"))
        (bind "${mod} + A" (dsp.exec "uwsm-app -- rofi -show run -show-icons"))
        (bind "${mod} + Return" (dsp.exec "uwsm-app -- ${term}"))

        # Screenshot (fn+f6, PrintScreen)
        (bind "${mod} + SHIFT + S" (dsp.exec "uwsm-app -- hyprshot -m region --notify copysave area"))
        (bind "PRINT" (dsp.exec "uwsm-app -- hyprshot -m output --notify copysave screen"))
        (bind "${mod} + PRINT" (dsp.exec "uwsm-app -- hyprshot -m window --notify copysave active"))

        # Universal copy/paste
        (bind "${mod} + C" (dsp.sendShortcut "CTRL" "Insert"))
        (bind "${mod} + V" (dsp.sendShortcut "SHIFT" "Insert"))
        (bind "${mod} + X" (dsp.sendShortcut "CTRL" "X"))

        # # Example binds, see https://wiki.hypr.land/Configuring/Binds/ for more
        # bind = $mod, Return, exec, $terminal
        # bind = $mod, W, killactive,
        # bind = $mod, M, exit,
        # #bind = $mod, E, exec, $fileManager
        # bind = $mod, V, togglefloating,
        # bind = $mod, r, exec, uwsm-app -- rofi -show drun -show-icons
        # bind = $mod, s, exec, uwsm-app -- rofi -show run -show-icons
        # #bind = $mod, S, exec, $menu
        #
        # # Move focus with mod + arrow keys
        # bind = $mod, left, movefocus, l
        # bind = $mod, right, movefocus, r
        # bind = $mod, up, movefocus, u
        # bind = $mod, down, movefocus, d

        # Resize column layout (Scrolling)
        (bindOpts "${mod} + CTRL + H" (dsp.layout "colresize -conf") { repeating = true; })
        (bindOpts "${mod} + CTRL + J" (dsp.layout "colresize -0.2") { repeating = true; })
        (bindOpts "${mod} + CTRL + K" (dsp.layout "colresize +0.2") { repeating = true; })
        (bindOpts "${mod} + CTRL + L" (dsp.layout "colresize +conf") { repeating = true; })

        # # Example special workspace (scratchpad)
        # bind = $mod, N, togglespecialworkspace, magic
        # bind = $mod SHIFT, N, movetoworkspace, special:magic

        # Focus panel columns
        (bind "ALT + TAB" (dsp.layout "move +col"))
        (bind "ALT + SHIFT + TAB" (dsp.layout "move -col"))

        # Swap column layout
        (bind "ALT + SHIFT + COMMA" (dsp.layout "swapcol l"))
        (bind "ALT + SHIFT + PERIOD" (dsp.layout "swapcol r"))
        (bind "ALT + SHIFT + mouse_down" (dsp.layout "swapcol l"))
        (bind "ALT + SHIFT + mouse_up" (dsp.layout "swapcol r"))

        # # Move/resize windows with mod + LMB/RMB and dragging
        # "${mod}, mouse:272, movewindow"
        # "${mod}, mouse:273, resizewindow"

        # Laptop multimedia keys for volume and LCD brightness
        (bindOpts "XF86AudioRaiseVolume" (dsp.exec "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+") {
          locked = true;
          repeating = true;
        })
        (bindOpts "XF86AudioLowerVolume" (dsp.exec "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-") {
          locked = true;
          repeating = true;
        })
        (bindOpts "XF86AudioMute" (dsp.exec "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle") {
          locked = true;
          repeating = true;
        })
        (bindOpts "XF86AudioMicMute" (dsp.exec "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle") {
          locked = true;
          repeating = true;
        })
        (bindOpts "XF86MonBrightnessUp" (dsp.exec "brightnessctl -e4 -n2 set 5%+") {
          locked = true;
          repeating = true;
        })
        (bindOpts "XF86MonBrightnessDown" (dsp.exec "brightnessctl -e4 -n2 set 5%-") {
          locked = true;
          repeating = true;
        })
      ]
      ++ lib.concatMap (
        ws:
        let
          key = toString (lib.mod ws 10);
        in
        [
          # Switch workspace with mod + [0-9]
          (bind "${mod} + ${key}" (dsp.focusWorkspace ws))
          # Move active window to a workspace with mod + SHIFT + [0-9]
          (bind "${mod} + SHIFT + ${key}" (dsp.moveToWorkspace ws))
        ]
      ) (lib.range 1 10);

      # Scroll through existing workspaces with mod + scroll
      # "$mod, mouse_down, workspace, e+1"
      # "$mod, mouse_up, workspace, e-1"

      # # Requires playerctl
      # bindl = , XF86AudioNext, exec, playerctl next
      # bindl = , XF86AudioPause, exec, playerctl play-pause
      # bindl = , XF86AudioPlay, exec, playerctl play-pause
      # bindl = , XF86AudioPrev, exec, playerctl previous
    };

    extraConfig = ''
      pcall(require, "local")
    '';
    # exec-once = [];
  };
}
