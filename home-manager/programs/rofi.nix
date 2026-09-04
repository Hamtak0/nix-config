{ config, ... }:
let
  inherit (config.lib.formats.rasi) mkLiteral;
in
{
  programs.rofi = {
    enable = true;
    font = "JetBrainsMono Nerd Font 12";
    terminal = "foot";

    extraConfig = {
      modi = "drun,run,filebrowser";
      show-icons = true;
      display-drun = " ";
      display-run = " ";
      display-filebrowser = " ";
      drun-display-format = "{name}";
    };

    theme = {
      "*" = {
        bg = mkLiteral "rgba(26, 21, 27, 0.86)";
        bg-alt = mkLiteral "rgba(45, 31, 39, 0.65)";
        border-col = mkLiteral "rgba(254, 223, 225, 0.18)";
        fg = mkLiteral "#fdeff2";
        fg-muted = mkLiteral "#7d5b6b";
        accent = mkLiteral "#f5a3b7";
        ink-dark = mkLiteral "#1a151b";
        transparent = mkLiteral "rgba(0, 0, 0, 0)";

        background-color = mkLiteral "@transparent";
        text-color = mkLiteral "@fg";
        margin = mkLiteral "0";
        padding = mkLiteral "0";
        spacing = mkLiteral "0";
      };

      "window" = {
        width = mkLiteral "960px";
        location = mkLiteral "center";
        anchor = mkLiteral "north";
        y-offset = mkLiteral "-140px";

        background-color = mkLiteral "@bg";
        border = mkLiteral "1px";
        border-color = mkLiteral "@border-col";
        border-radius = mkLiteral "18px";
        padding = mkLiteral "16px";
      };

      "mainbox" = {
        children = map mkLiteral [
          "inputbar"
          "listview"
        ];
        spacing = mkLiteral "8px";
      };

      "inputbar" = {
        children = map mkLiteral [
          "prompt"
          "entry"
        ];
        background-color = mkLiteral "@bg-alt";
        border = mkLiteral "1px";
        border-color = mkLiteral "@border-col";
        border-radius = mkLiteral "12px";
        padding = mkLiteral "14px 18px";
        spacing = mkLiteral "14px";
      };

      "prompt" = {
        text-color = mkLiteral "@accent";
        font = "JetBrainsMono Nerd Font Bold 14";
        vertical-align = mkLiteral "0.5";
      };

      "entry" = {
        placeholder = "Search or type a command...";
        placeholder-color = mkLiteral "@fg-muted";
        text-color = mkLiteral "@fg";
        font = "JetBrainsMono Nerd Font 13";
        vertical-align = mkLiteral "0.5";
      };

      "listview" = {
        lines = 5;
        columns = 1;
        fixed-height = true;
        scrollbar = false;
        spacing = mkLiteral "4px";
        padding = mkLiteral "6px 0px 0px 0px";
      };

      "element" = {
        padding = mkLiteral "10px 16px";
        border-radius = mkLiteral "10px";
        spacing = mkLiteral "14px";
        text-color = mkLiteral "@fg";
      };

      "element selected.normal" = {
        background-color = mkLiteral "@accent";
        text-color = mkLiteral "@ink-dark";
      };

      "element selected.urgent" = {
        background-color = mkLiteral "#d05a7e";
        text-color = mkLiteral "#fdeff2";
      };

      "element-icon" = {
        size = mkLiteral "26px";
        vertical-align = mkLiteral "0.5";
      };

      "element-text" = {
        text-color = mkLiteral "inherit";
        vertical-align = mkLiteral "0.5";
      };
    };
  };
}
