{ lib, pkgs, ... }:

{

  # yabai -m rule --add app="^System Preferences$" sticky=on layer=above manage=off
  # yabai -m rule --add app="^Karabiner-Elements$" sticky=on layer=above manage=off
  # yabai -m rule --add app="^Karabiner-EventViewer$" sticky=on layer=above manage=off
  # yabai -m rule --add app="^Finder$" sticky=on layer=above manage=off
  # yabai -m rule --add app="^Keka$" sticky=on layer=above manage=off
  # yabai -m rule --add app="^Disk Utility$" sticky=on layer=above manage=off
  # yabai -m rule --add app="^System Information$" sticky=on layer=above manage=off
  # yabai -m rule --add app="^Activity Monitor$" sticky=on layer=above manage=off
  # yabai -m rule --add app="Fantastical" manage=off
  # yabai -m rule --add app="^Spotify$" manage=off
  # yabai -m rule --add app="^Calendar$" manage=off
  # yabai -m rule --add app="^Slack$" manage=off
  # yabai -m rule --add app="^Discord$" manage=off
  # yabai -m rule --add app="^Mail$" manage=off

  services.yabai = {
    enable = true;
    # enableScriptingAddition = true;
    enableScriptingAddition = false;
    package = pkgs.yabai;
    config = {
      window_border = "off";
      # window_border_width = 5;
      # active_window_border_color = "0xff3B4252";
      # normal_window_border_color = "0xff2E3440";
      focus_follows_mouse = "autoraise";
      mouse_follows_focus = "off";
      mouse_drop_action = "stack";
      window_placement = "second_child";
      window_opacity = "off";
      window_topmost = "on";
      window_shadow = "on";
      active_window_opacity = "1.0";
      normal_window_opacity = "1.0";
      split_ratio = "0.50";
      auto_balance = "on";
      mouse_modifier = "fn";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      layout = "bsp";
      top_padding = 18;
      bottom_padding = 46;
      left_padding = 18;
      right_padding = 18;
      window_gap = 18;
    };
  };

  # ## Close active application
  # hyper - delete : $(yabai -m window $(yabai -m query --windows --window | jq -re ".id") --close)

  # ## open terminal
  # hyper - return : /Applications/iTerm.app/Contents/MacOS/iTerm2

  # ## swap window - colemak mapping
  # # shift + alt + ctrl - o : yabai -m window --swap west
  # # shift + alt + ctrl - e : yabai -m window --swap south
  # # shift + alt + ctrl - i : yabai -m window --swap north
  # # shift + alt + ctrl - n : yabai -m window --swap east

  # ## Focus app -  colemak mapping
  # shift + alt + ctrl - o : yabai -m window --focus east
  # shift + alt + ctrl - e : yabai -m window --focus south
  # shift + alt + ctrl - i : yabai -m window --focus north
  # shift + alt + ctrl - n : yabai -m window --focus west

  # ## rotate tree 90
  # hyper - r : yabai -m space --rotate 90

  # ## flip the tree vertically
  # hyper - 4 : yabai -m space --mirror y-axis
  # # mirror tree y-axis
  # #alt - y : yabai -m space --mirror y-axis
  # ## mirror tree x-axis
  # #alt - x : yabai -m space --mirror x-axis

  # #Move active window to next space on current display
  # shift + lalt + lcmd + ctrl + ralt - 1 : yabai -m query --spaces --space | jq -re ".index" | xargs -I {} bash -c "if [[ '{}' = '1' ]]; then yabai -m window --space 2; elif [[ '{}' = '2' ]]; then yabai -m window --space 1; fi"
  # shift + lalt + lcmd + ctrl + ralt - 2 : yabai -m query --spaces --space | jq -re ".index" | xargs -I {} bash -c "if [[ '{}' = '3' ]]; then yabai -m window --space 4; elif [[ '{}' = '4' ]]; then yabai -m window --space 3; fi"
  # shift + lalt + lcmd + ctrl + ralt - 3 : yabai -m query --spaces --space | jq -re ".index" | xargs -I {} bash -c "if [[ '{}' = '5' ]]; then yabai -m window --space 6; elif [[ '{}' = '6' ]]; then yabai -m window --space 5; fi"

  # ## fast focus desktop
  # shift + alt + ctrl - x : yabai -m space --focus last
  # shift + alt + ctrl - z : yabai -m space --focus prev
  # shift + alt + ctrl - c : yabai -m space --focus next
  # shift + alt + ctrl - 1 : yabai -m space --focus 1
  # shift + alt + ctrl - 2 : yabai -m space --focus 2
  # shift + alt + ctrl - 3 : yabai -m space --focus 3
  # shift + alt + ctrl - 4 : yabai -m space --focus 4
  # shift + alt + ctrl - 5 : yabai -m space --focus 5
  # shift + alt + ctrl - 6 : yabai -m space --focus 6
  # shift + alt + ctrl - 7 : yabai -m space --focus 7
  # shift + alt + ctrl - 8 : yabai -m space --focus 8
  # shift + alt + ctrl - 9 : yabai -m space --focus 9

  # ## toggle window fullscreen zoom
  # hyper - f : yabai -m window --toggle zoom-fullscreen

  services.skhd = {
    enable = true;
    package = pkgs.skhd;
    skhdConfig = ''
      ## HYPER == SHIFT + CMD + ALT + OPTION
      ## MEH == SHIFT + ALT + CTRL

      ctrl + alt - h : yabai -m window --focus west
      ctrl + alt - j : yabai -m window --focus south
      ctrl + alt - k : yabai -m window --focus north
      ctrl + alt - l : yabai -m window --focus east
      # Fill space with window
      ctrl + alt - 0 : yabai -m window --grid 1:1:0:0:1:1
      # Move window
      ctrl + alt - f : yabai -m window --space next; yabai -m space --focus next
      ctrl + alt - s : yabai -m window --space prev; yabai -m space --focus prev
      # Close current window
      ctrl + alt - w : $(yabai -m window $(yabai -m query --windows --window | jq -re ".id") --close)
      # Rotate tree
      ctrl + alt - r : yabai -m space --rotate 90
      # Open application
      # ctrl + alt - enter : alacritty
      cmd - return : alacritty
      ctrl + alt - e : emacs
      ctrl + alt - b : open -a Safari
      ctrl + alt - t : yabai -m window --toggle float;\
        yabai -m window --grid 4:4:1:1:2:2
      ctrl + alt - p : yabai -m window --toggle sticky;\
        yabai -m window --toggle topmost;\
        yabai -m window --toggle pip
    '';

  };

  homebrew = {
    brewPrefix = "/opt/homebrew/bin";
    enable = true;
    autoUpdate = true;
    cleanup = "zap"; # keep it clean
    global = {
      brewfile = true;
      noLock = true;
    };

    taps = [
      "homebrew/core" # core
      "homebrew/cask" # we're using this for casks, after all
      "homebrew/cask-versions" # needed for firefox-nightly and discord-canary
      "epk/epk"
    ];

    casks = [
      "alacritty"
      "firefox-nightly"
      # "via" # keyboard config
      "slack"
      "discord-canary"

      "protonmail-bridge"
      "protonvpn"

      "hammerspoon" # wm

      "font-sf-mono-nerd-font"
    ];
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };
  system.defaults = {
    dock = {
      autohide = true;
      showhidden = true;
      mru-spaces = false;
    };
    finder = {
      AppleShowAllExtensions = false;
      QuitMenuItem = true;
      FXEnableExtensionChangeWarning = false;
    };
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleKeyboardUIMode = 3;
      ApplePressAndHoldEnabled = false;
      AppleFontSmoothing = 1;
      _HIHideMenuBar = false;
      InitialKeyRepeat = 10;
      KeyRepeat = 2;
      "com.apple.mouse.tapBehavior" = 1;
    };
  };

}
