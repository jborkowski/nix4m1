{ lib, pkgs, ... }:

{


  services.yabai = {
    enable = true;
    # enableScriptingAddition = true;
    enableScriptingAddition = false;
    package = pkgs.yabai;
    config = {
      window_border = "off";
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
    extraConfig = ''
      # rules

      # yabai -m rule --add label="App Store" app="^App Store$" manage=off
      # yabai -m rule --add label="Activity Monitor" app="^Activity Monitor$" manage=off
      # yabai -m rule --add label="Calculator" app="^Calculator$" manage=off
      # yabai -m rule --add label="Dictionary" app="^Dictionary$" manage=off
      # yabai -m rule --add label="About This Mac" app="System Information" title="About This Mac" manage=off
      # yabai -m rule --add app="^System Preferences$" sticky=on layer=above manage=off
      # yabai -m rule --add app="^Finder$" sticky=on layer=above manage=off
      # yabai -m rule --add app="^Keka$" sticky=on layer=above manage=off
      # yabai -m rule --add app="^Disk Utility$" sticky=on layer=above manage=off
      # yabai -m rule --add app="^Spotify$" manage=off
      # yabai -m rule --add app="^Calendar$" manage=off
      # yabai -m rule --add app="^emacs$" manage=on
      # yabai -m rule --add app="^Books$" manage=off layer=above


      # yabai -m rule --add app="^Slack$" manage=off
      # yabai -m rule --add app="^Discord$" manage=off
      # yabai -m rule --add app="^Mail$" manage=off sticky=on
    '';
  };

  services.skhd = {
    enable = true;
    package = pkgs.skhd;
    skhdConfig = ''
      # open terminal
      cmd - return : alacritty

      # open emacs
      cmd - e : emacsclient -c
      cmd + shift -e : emacsclient --eval "(emacs-everywhere)"


      # open browser
      cmd - b : open -a Chrome


      # colemak home row
      lalt - n : yabai -m window --focus west
      lalt - e : yabai -m window --focus south
      lalt - i : yabai -m window --focus north
      lalt - o : yabai -m window --focus east


      # focus spaces
      cmd + ctrl - x : yabai -m space --focus recent
      cmd - 1 : yabai -m space --focus 1
      cmd - 2 : yabai -m space --focus 2
      cmd - 3 : yabai -m space --focus 3
      cmd - 4 : yabai -m space --focus 4
      cmd - 5 : yabai -m space --focus 5
      cmd - 6 : yabai -m space --focus 6
      cmd - 7 : yabai -m space --focus 7
      cmd - 8 : yabai -m space --focus 8

      # focus on next/prev space
      ctrl + alt - q : yabai -m space --focus prev
      ctrl + alt - f : yabai -m space --focus next
      ctrl + alt - x : yabai -m space --focus last

      # rotate tree
      ctrl + alt - r : yabai -m space --rotate 90

      # float / unfloat window and center on screen
      lalt - t : yabai -m window --toggle float;\
                 yabai -m window --grid 4:4:1:1:2:2

      # toggle window fullscreen
      ralt - yabai : f -m window --toggle zoom-fullscreen

      # move window
      # ctrl + alt - f : yabai -m window --space next; yabai -m space --focus next
      # ctrl + alt - s : yabai -m window --space prev; yabai -m space --focus prev


      # close current window
      # ctrl + alt - w : $(yabai -m window $(yabai -m query --windows --window | jq -re ".id") --close)

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

  # services.kmonad = {
  #   enable = true;
  #   configfiles  = [

  #     #  -- (builtins.readFile "./mbp13.kbd")
  #   ];
  # };

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
      InitialKeyRepeat = 11; # normal minimum is 15 (225 ms)
      KeyRepeat = 1; # normal minimum is 2 (30 ms) - 1 = 15 ms
      "com.apple.mouse.tapBehavior" = 1;
    };
  };

}
