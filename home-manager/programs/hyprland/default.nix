{
  inputs,
  pkgs,
  ...
}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    systemd.enable = false;
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprscrolling 
    ];
    settings = {
      monitor = [
        # "desc:Chimei Innolux Corporation 0x1521, preferred, auto, 1"
        "eDP-1, preferred, auto, 1"
        ", preferred, auto, 1, mirror, eDP-1"
      ];

      input = {
        kb_layout = "us,th";
	kb_options = "grp:win_space_toggle";
	numlock_by_default = true;
	repeat_rate = 40;
        repeat_delay = 275;
        follow_mouse = 1;
        sensitivity = 0;
        accel_profile = "flat";
	natural_scroll = true;
      };

      general = {
        gaps_in = 1;
        gaps_out = 0;
        border_size = 0;
        layout = "scrolling";
        allow_tearing = true;
      };

      plugin = {
        hyprscrolling = {
	  fullscreen_on_one_column = true;
	  focus_fit_method = 1;
	};
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

      animations = {
        enabled = true;
        animation = [
          "windowsIn, 1, 3, default, popin 50%"
          "windowsOut, 1, 4, default, popin 75%"
          "windowsMove, 1, 3, default"
          "border, 1, 10, default"
          "borderangle, 1, 7.5, default"
          "fade, 1, 7, default"
          "workspaces, 1, 3, default, slidefadevert 10%"
          "specialWorkspace, 1, 4, default, slidefadevert 5%"
          "layers, 1, 2.5, default, fade"
          "fadeLayers, 1, 2.5, default"
        ];
      };

      # animations {
      #     enabled = true # please :)
      #     # Default animations, see https://wiki.hypr.land/Configuring/Animations/ for more
      # 
      #     bezier = easeOutQuint,0.23,1,0.32,1
      #     bezier = easeInOutCubic,0.65,0.05,0.36,1
      #     bezier = linear,0,0,1,1
      #     bezier = almostLinear,0.5,0.5,0.75,1.0
      #     bezier = quick,0.15,0,0.1,1
      # 
      #     animation = global, 1, 10, default
      #     animation = border, 1, 5.39, easeOutQuint
      #     animation = windows, 1, 4.79, easeOutQuint
      #     animation = windowsIn, 1, 4.1, easeOutQuint, popin 87%
      #     animation = windowsOut, 1, 1.49, linear, popin 87%
      #     animation = fadeIn, 1, 1.73, almostLinear
      #     animation = fadeOut, 1, 1.46, almostLinear
      #     animation = fade, 1, 3.03, quick
      #     animation = layers, 1, 3.81, easeOutQuint
      #     animation = layersIn, 1, 4, easeOutQuint, fade
      #     animation = layersOut, 1, 1.5, linear, fade
      #     animation = fadeLayersIn, 1, 1.79, almostLinear
      #     animation = fadeLayersOut, 1, 1.39, almostLinear
      #     animation = workspaces, 1, 1.94, almostLinear, fade
      #     animation = workspacesIn, 1, 1.21, almostLinear, fade
      #     animation = workspacesOut, 1, 1.94, almostLinear, fade
      # }

      # See https://wiki.hypr.land/Configuring/Window-Rules/ for more
      # See https://wiki.hypr.land/Configuring/Workspace-Rules/ for workspace rules
       
      windowrulev2 = [
        # Ignore maximize requests from apps. You'll probably like this.
        "suppressevent maximize, class:.*"
         
        # Fix some dragging issues with XWayland
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];

      "$mod" = "SUPER";

      "$term" = "foot";
      "$term_alt" = "foot";

      binde = [
        "$mod CTRL, h, layoutmsg, colresize -conf"
        "$mod CTRL, h, layoutmsg, colresize -0.2"
        "$mod CTRL, h, layoutmsg, colresize +0.2"
        "$mod CTRL, h, layoutmsg, colresize +conf"

        "$mod, Tab, layoutmsg, move +col"
        "$mod SHIFT, Tab, layoutmsg, move -col"
      ];

      bind = [
	"$mod, w, killactive"
	"$mod, r, exec, uwsm-app -- rofi -show drun -show-icons"
	"$mod, a, exec, uwsm-app -- rofi -show run -show-icons"

	"$mod, Return, exec, uwsm-app -- $term"

	# Screenshot fn+f6
	"$mod Shift_L, s, exec, uwsm-app -- grimblast --notify copysave area"
	" , Print, exec, uwsm-app -- grimblast --notify copysave screen"
    	"$mod, Print, exec, uwsm-app -- grimblast --notify copysave active"

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
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
        
        # Move active window to a workspace with mod + SHIFT + [0-9]
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
        
        # # Example special workspace (scratchpad)
        # bind = $mod, N, togglespecialworkspace, magic
        # bind = $mod SHIFT, N, movetoworkspace, special:magic
        # 
        # # Scroll through existing workspaces with mod + scroll
        # bind = $mod, mouse_down, workspace, e+1
        # bind = $mod, mouse_up, workspace, e-1
        # 
        # # Move/resize windows with mod + LMB/RMB and dragging
        # bindm = $mod, mouse:272, movewindow
        # bindm = $mod, mouse:273, resizewindow
        # 
        # # Laptop multimedia keys for volume and LCD brightness
        # bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
        # bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        # bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        # bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
        # bindel = ,XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+
        # bindel = ,XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-
        # 
        # # Requires playerctl
        # bindl = , XF86AudioNext, exec, playerctl next
        # bindl = , XF86AudioPause, exec, playerctl play-pause
        # bindl = , XF86AudioPlay, exec, playerctl play-pause
        # bindl = , XF86AudioPrev, exec, playerctl previous
      ];
    };
  };
}
