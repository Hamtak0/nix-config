{
  config,
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

      gesture = [
        # finger, direction, action
        "3, left, dispatcher, layoutmsg, move +col"
        "3, right, dispatcher, layoutmsg, move -col"

        "4, up, dispatcher, workspace, +1"
        "4, down, dispatcher, workspace, -1"
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

      binde = [
        "${mod} CTRL, h, layoutmsg, colresize -conf"
        "${mod} CTRL, j, layoutmsg, colresize -0.2"
        "${mod} CTRL, k, layoutmsg, colresize +0.2"
        "${mod} CTRL, l, layoutmsg, colresize +conf"

        # Focus panel columns
        "ALT, Tab, layoutmsg, move +col"
        "ALT SHIFT, Tab, layoutmsg, move -col"

        "ALT_SHIFT, comma, layoutmsg, swapcol l"
        "ALT_SHIFT, period, layoutmsg, swapcol r"
        "ALT_SHIFT, mouse_down, layoutmsg, swapcol l"
        "ALT_SHIFT, mouse_up, layoutmsg, swapcol r"
      ];

      bind = [
        "${mod}, w, killactive"
        "${mod}, r, exec, uwsm-app -- rofi -show drun -show-icons"
        "${mod}, a, exec, uwsm-app -- rofi -show run -show-icons"
        "${mod}, l, exec, uwsm-app -- hyprlock"
        "${mod}, Return, exec, uwsm-app -- ${term}"

        # Screenshot fn+f6
        "${mod} Shift_L, s, exec, uwsm-app -- hyprshot -m region --notify copysave area"
        " , Print, exec, uwsm-app -- hyprshot -m output --notify copysave screen"
        "${mod}, Print, exec, uwsm-app -- hyprshot -m window --notify copysave active"

        # # Example binds, see https://wiki.hypr.land/Configuring/Binds/ for more
        # bind = $mod, Return, exec, $terminal
        # bind = $mod, W, killactive,
        # bind = $mod, M, exit,
        # #bind = $mod, E, exec, $fileManager
        # bind = $mod, V, togglefloating,
        # bind = $mod, r, exec, uwsm-app -- rofi -show drun -show-icons
        # bind = $mod, s, exec, uwsm-app -- rofi -show run -show-icons
        # #bind = $mod, S, exec, $menu
        # #bind = $mod, P, pseudo, # dwindle
        # #bind = $mod, J, togglesplit, # dwindle
        #
        # # Move focus with mod + arrow keys
        # bind = $mod, left, movefocus, l
        # bind = $mod, right, movefocus, r
        # bind = $mod, up, movefocus, u
        # bind = $mod, down, movefocus, d

        # Switch workspaces with mod + [0-9]
        "${mod}, 1, workspace, 1"
        "${mod}, 2, workspace, 2"
        "${mod}, 3, workspace, 3"
        "${mod}, 4, workspace, 4"
        "${mod}, 5, workspace, 5"
        "${mod}, 6, workspace, 6"
        "${mod}, 7, workspace, 7"
        "${mod}, 8, workspace, 8"
        "${mod}, 9, workspace, 9"
        "${mod}, 0, workspace, 10"

        # Move active window to a workspace with mod + SHIFT + [0-9]
        "${mod} SHIFT, 1, movetoworkspace, 1"
        "${mod} SHIFT, 2, movetoworkspace, 2"
        "${mod} SHIFT, 3, movetoworkspace, 3"
        "${mod} SHIFT, 4, movetoworkspace, 4"
        "${mod} SHIFT, 5, movetoworkspace, 5"
        "${mod} SHIFT, 6, movetoworkspace, 6"
        "${mod} SHIFT, 7, movetoworkspace, 7"
        "${mod} SHIFT, 8, movetoworkspace, 8"
        "${mod} SHIFT, 9, movetoworkspace, 9"
        "${mod} SHIFT, 0, movetoworkspace, 10"

        # Scroll through existing workspaces with mod + scroll
        # "$mod, mouse_down, workspace, e+1"
        # "$mod, mouse_up, workspace, e-1"
      ];

      # # Example special workspace (scratchpad)
      # bind = $mod, N, togglespecialworkspace, magic
      # bind = $mod SHIFT, N, movetoworkspace, special:magic

      # Move/resize windows with mod + LMB/RMB and dragging
      bindm = [
        "${mod}, mouse:272, movewindow"
        "${mod}, mouse:273, resizewindow"
      ];

      # Laptop multimedia keys for volume and LCD brightness
      bindel = [
        " ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        " ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        " ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        " ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        " ,XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        " ,XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];

      # # Requires playerctl
      # bindl = , XF86AudioNext, exec, playerctl next
      # bindl = , XF86AudioPause, exec, playerctl play-pause
      # bindl = , XF86AudioPlay, exec, playerctl play-pause
      # bindl = , XF86AudioPrev, exec, playerctl previous

      source = [
        "${config.home.homeDirectory}/.config/hypr/local.conf"
      ];
    };

    # exec-once = [];
  };
}
