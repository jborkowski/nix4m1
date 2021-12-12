{lib, pkgs, ... }:

{
  home-manager.users.jobo.programs.alacritty = {
    enable = true;
    # We need to give it a dummy package
    package = pkgs.runCommand "alacritty-0.0.0" { } "mkdir $out";
    settings = {
      window.padding.x = 45;
      window.padding.y = 45;
      window.decorations = "buttonless";
      window.dynamic_title = true;
      live_config_reload = true;
      mouse.hide_when_typing = true;
      use_thin_strokes = true;
      cursor.style = "Beam";

      font = {
        size = 14;
        normal.family = "Liga SFMono Nerd Font";
        normal.style = "Light";
        bold.family = "Liga SFMono Nerd Font";
        bold.style = "Bold";
        italic.family = "Liga SFMono Nerd Font";
        italic.style = "Italic";
      };

      colors = {
        cursor.cursor = "#bbc2cf";
        primary.background = "#242730";
        primary.foreground = "#bbc2cf";
        normal = {
          black =   "#2a2e38";
          red =     "#ff665c";
          green =   "#7bc275";
          yellow =  "#FCCE7B";
          blue =    "#5cEfFF";
          magenta = "#C57BDB";
          cyan =    "#51afef";
          white =   "#bbc2cf";
        };
        bright = {
          black =    "#484854";
          red =      "#ff665c";
          green =    "#7bc275";
          yellow =   "#fcce7b";
          blue =     "#5cefff";
          magenta =  "#c57bdb";
          cyan =     "#51afef";
          white =    "#bbc2cf";
        };
      };
    };
  };
}
