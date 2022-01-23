{ config, lib, pkgs, ... }:

{

  programs.fish.enable = true;
  environment.shells = with pkgs; [ fish ];
  users.users.jobo = {
    home = "/Users/jobo";
    shell = pkgs.fish;
  };

  system.activationScripts.postActivation.text = ''
    # Set the default shell as fish for the user
    sudo chsh -s ${lib.getBin pkgs.fish}/bin/fish jobo
  '';

  programs.fish.shellAliases = with pkgs; {
    ":q" = "exit";
    e = "emacsclient -c";
    vim = "nvim";
    ll =
      "exa -lF --color-scale --no-user --no-time --no-permissions --group-directories-first --icons -a";
    ls = "exa -lF --group-directories-first --icons -a";
    ps = "ps";
    tree = "tree -a -C";
    cat = "bat";
    top = "btm";
    cp = "xcp";
    find = "fd";
    calc = "emacs -f full-calc";
    nix-fish = "nix-shell --command fish";
  };

  programs.fish.promptInit = ''
    set -g fish_greeting ""
    set -U fish_color_autosuggestion      brblack
    set -U fish_color_cancel              -r
    set -U fish_color_command             green
    set -U fish_color_comment             magenta
    set -U fish_color_cwd                 green
    set -U fish_color_cwd_root            red
    set -U fish_color_end                 magenta
    set -U fish_color_error               red
    set -U fish_color_escape              cyan
    set -U fish_color_history_current     --bold
    set -U fish_color_host                normal
    set -U fish_color_normal              normal
    set -U fish_color_operator            cyan
    set -U fish_color_param               blue
    set -U fish_color_quote               yellow
    set -U fish_color_redirection         yellow
    set -U fish_color_search_match        'yellow' '--background=brightblack'
    set -U fish_color_selection           'white' '--bold' '--background=brightblack'
    set -U fish_color_status              red
    set -U fish_color_user                green
    set -U fish_color_valid_path          --underline
    set -U fish_pager_color_completion    normal
    set -U fish_pager_color_description   yellow
    set -U fish_pager_color_prefix        'white' '--bold' '--underline'
    set -U fish_pager_color_progress      'white' '--background=cyan'

    # prompt
    set fish_prompt_pwd_dir_length 1
    set __fish_git_prompt_show_informative_status 1
    set fish_color_command green
    set fish_color_param $fish_color_normal
    set __fish_git_prompt_showdirtystate 'yes'
    set __fish_git_prompt_showupstream 'yes'
    set __fish_git_prompt_color_branch brown
    set __fish_git_prompt_color_dirtystate FCBC47
    set __fish_git_prompt_color_stagedstate yellow
    set __fish_git_prompt_color_upstream cyan
    set __fish_git_prompt_color_cleanstate green
    set __fish_git_prompt_color_invalidstate red
    set __fish_git_prompt_char_dirtystate '~~'
    set __fish_git_prompt_char_stateseparator ' '
    set __fish_git_prompt_char_untrackedfiles ' ...'
    set __fish_git_prompt_char_cleanstate '✓'
    set __fish_git_prompt_char_stagedstate '-> '
    set __fish_git_prompt_char_conflictedstate "✕"
    set __fish_git_prompt_char_upstream_prefix ""
    set __fish_git_prompt_char_upstream_equal ""
    set __fish_git_prompt_char_upstream_ahead '>>='
    set __fish_git_prompt_char_upstream_behind '=<<'
    set __fish_git_prompt_char_upstream_diverged '<=>'

    function _print_in_color
      set -l string $argv[1]
      set -l color  $argv[2]
      set_color $color
      printf $string
      set_color normal
    end
    function _prompt_color_for_status
      if test $argv[1] -eq 0
        echo magenta
      else
        echo red
      end
    end
    function fish_prompt
        set -l last_status $status
        set -l nix_shell_info (
          if test -n "$IN_NIX_SHELL"
            echo -n " [nix-shell]"
          end
        )
        if test $HOME != $PWD
            _print_in_color ""(prompt_pwd) blue
        end
        __fish_git_prompt " (%s)"
        _print_in_color "$nix_shell_info λ " (_prompt_color_for_status $last_status) ]
    end

    function fish_user_key_bindings
      if command -s fzf-share >/dev/null
        source (fzf-share)/key-bindings.fish
      end

      fzf_key_bindings
    end

  '';

  programs.fish.interactiveShellInit = ''
    set -g fish_greeting ""
     if not set -q TMUX
       tmux new-session -A -s main
     end
     zoxide init fish --cmd cd | source
     set -x EDITOR "emacs"
     set -x PATH ~/.ghcup/bin ~/.local/bin $PATH

  '';

  home-manager.users.jobo.programs.bat = {
    enable = true;
    config = { theme = "Nord"; };
  };

  programs.tmux.enable = true;
  programs.tmux.extraConfig = ''
    # make sure fish works in tmux
    set -g default-terminal "screen-256color"

    set -sa terminal-overrides ',xterm-256color:RGB'
    # so that escapes register immidiately in vim
    set -sg escape-time 1
    set -g focus-events on
    # mouse support
    set -g mouse on
    # change prefix to C-a
    set -g prefix C-a
    bind C-a send-prefix
    unbind C-b
    # extend scrollback
    set-option -g history-limit 5000

    set -g mode-keys emacs
    set -g status-keys emacs
    # emacs-like pane resizing
    bind -r M-p resize-pane -U
    bind -r M-n resize-pane -D
    bind -r M-f resize-pane -L
    bind -r M-b resize-pane -R
    # emacs-like pane switching
    bind -r C-p select-pane -U
    bind -r C-n select-pane -D
    bind -r C-f select-pane -L
    bind -r C-b select-pane -R
    # styling
    set -g status-style fg=white,bg=default
    set -g status-left ""
    set -g status-right ""
    set -g status-justify centre
    set -g status-position bottom
    set -g pane-active-border-style bg=default,fg=default
    set -g pane-border-style fg=default
    set -g window-status-current-format "#[fg=cyan]#[fg=black]#[bg=cyan]#I #[bg=brightblack]#[fg=white] #W#[fg=brightblack]#[bg=default] #[bg=default] #[fg=magenta]#[fg=black]#[bg=magenta]λ #[fg=white]#[bg=brightblack] %a %d %b #[fg=magenta]%R#[fg=brightblack]#[bg=default]"
    set -g window-status-format "#[fg=magenta]#[fg=black]#[bg=magenta]#I #[bg=brightblack]#[fg=white] #W#[fg=brightblack]#[bg=default] "
  '';

  environment.systemPackages = with pkgs; [ exa neofetch fzf mosh ];
}
