{ config, ... }:
{
  programs.rofi = {
    enable = true;
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
      in {
      "#configuration" = {
        display-drun = "";
        display-run = "";
        display-window = "";
        display-ssh = "~#";
        show-icons = true;
        sidebar-mode = false;
        font = "Source Code Pro 15";
      };

      "*" = {
        text-color = mkLiteral "@foreground";
        active-background = mkLiteral "rgb(170, 70, 104)";
        active-foreground = mkLiteral "@foreground";
        normal-background = mkLiteral "@background";
        normal-foreground = mkLiteral "@foreground";
        urgent-background = mkLiteral "#9E2A5E";
        urgent-foreground = mkLiteral "@foreground";
        alternate-active-background = mkLiteral "@background";
        alternate-active-foreground = mkLiteral "@foreground";
        alternate-normal-background = mkLiteral "@background";
        alternate-normal-foreground = mkLiteral "@foreground";
        alternate-urgent-background = mkLiteral "@background";
        alternate-urgent-foreground = mkLiteral "@foreground";
        selected-active-background = mkLiteral "#9E2A5E";
        selected-active-foreground = mkLiteral "@foreground";
        selected-normal-background = mkLiteral "rgb(170, 70, 104)";
        selected-normal-foreground = mkLiteral "#0c0816";
        selected-urgent-background = mkLiteral "#9D596B";
        selected-urgent-foreground = mkLiteral "@foreground";
        background-color = mkLiteral "#0c0816";
        background = mkLiteral "#D03C6E30";
        foreground = mkLiteral "#8fc5c6";
        spacing = 0;
      };

      "#window" = {
        location = mkLiteral "west";
        anchor = mkLiteral "west";
        height = mkLiteral "70%";
        width = mkLiteral "25%";
        orientation = mkLiteral "vertical";
        children = mkLiteral "[mainbox]";
        border = mkLiteral "2px 2px 2px 0px";
        border-color = mkLiteral "@active-background";
        hide-scrollbar = true;
      };

      "#mainbox" = {
        spacing = mkLiteral "0.2em";
        children = mkLiteral "[inputbar, listview]";
      };



      "#listview" = {
        spacing = mkLiteral "0.6em";
        dynamic = false;
        cycle = true;
        padding = mkLiteral "0px 5px 0px 5px";
      };

      "#inputbar" = {
        border-radius = mkLiteral "50%";
        padding = mkLiteral "5px";
        border-spacing = mkLiteral "5px 0 0 0";
        border = mkLiteral "1px";
        spacing = mkLiteral "10px";
        margin = mkLiteral "5px 0 10px";
        border-color = mkLiteral "@foreground";
      };

      "#entry" = {
        padding = mkLiteral "2px";
      };


      "#prompt" = {
        padding = mkLiteral "5px";
        background-color = mkLiteral "@foreground";
        text-color = mkLiteral "@background-color";
        border = mkLiteral "1px";
        border-radius = mkLiteral "50%";
      };


      "#element" = {
        padding = mkLiteral "10px";
        border-radius = mkLiteral "50%";
      };

      "#element normal.normal" = {
        background-color = mkLiteral "@normal-background";
        text-color = mkLiteral "@normal-foreground";
      };

      "#element normal.urgent" = {
        background-color = mkLiteral "@urgent-background";
        text-color = mkLiteral "@urgent-foreground";
      };

      "#element normal.active" = {
        background-color = mkLiteral "@active-background";
        text-color = mkLiteral "@active-foreground";
      };

      "#element selected.normal" = {
        background-color = mkLiteral "@selected-normal-background";
        text-color = mkLiteral "@selected-normal-foreground";
        border-color = mkLiteral "@active-background";
      };

      "#element selected.urgent" = {
        background-color = mkLiteral "@selected-urgent-background";
        text-color = mkLiteral "@selected-urgent-foreground";
      };

      "#element selected.active" = {
        background-color = mkLiteral "@selected-active-background";
        text-color = mkLiteral "@selected-active-foreground";
      };

      "#element alternate.normal" = {
        background-color = mkLiteral "@normal-background";
        text-color = mkLiteral "@normal-foreground";
      };

      "#element alternate.urgent" = {
        background-color = mkLiteral "@urgent-background";
        text-color = mkLiteral "@urgent-foreground";
      };

      "#element alternate.active" = {
        background-color = mkLiteral "@active-background";
        text-color = mkLiteral "@active-foreground";
      };
    };
  };
}
