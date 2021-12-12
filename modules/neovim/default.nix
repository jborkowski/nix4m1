{ pkgs, ... }:
let
  custom-plugins = pkgs.callPackage ./plugins.nix {
    inherit (pkgs.vimUtils) buildVimPlugin;
    inherit (pkgs.vimUtils) buildVimPluginFrom2Nix;
    inherit (pkgs) fetchFromGitHub;
  };

  plugins = pkgs.vimPlugins // custom-plugins;

  overriddenPlugins = with pkgs; [ ];

  myVimPlugins = with plugins;
    [
      nord-vim
      purescript-vim
      ctrlp
      ctrlp-py-matcher
      lastpos
      fugitive
      tslime
      neocomplete
      fzf-vim
      fzfWrapper
      nerdcommenter
      ack-vim
      auto-pairs
      yajs-vim
      commentary-vim
      coc-yank # yank plugin for CoC
      dhall-vim # Syntax highlighting for Dhall lang
      fzf-hoogle # search hoogle with fzf
      fzf-vim # fuzzy finder
      neovim-ghcid # ghcid for haskell
      lightline-vim # configurable status line (can be used by coc)
      multiple-cursors # Multiple cursors selection, etc
      neomake # run programs asynchronously and highlight errors
      nerdcommenter # code commenter
      nerdtree # tree explorer
      quickfix-reflector-vim # make modifications right in the quickfix window
      rainbow_parentheses-vim # for nested parentheses
      tender-vim # a clean dark theme
      vim-airline # bottom status bar
      vim-airline-themes
      vim-easy-align # alignment plugin
      vim-easymotion # highlights keys to move quickly
      vim-nix # nix support (highlighting, etc)
      vim-repeat # repeat plugin commands with (.)
      vim-surround # quickly edit surroundings (brackets, html tags, etc)
      vim-tmux # syntax highlighting for tmux conf file and more
      vim-which-key # display possible keybindings of the command you type.
      vim-stylish-haskell
      vim-gitgutter # A Vim plugin which shows a git diff
      vim-auto-save # Automatically saves changes to dis
      vim-nix # Support for writing Nix expressions in vim
      vim-trailing-whitespace
      vim-markdown
      coc-nvim
    ] ++ overriddenPlugins;

  baseConfig = builtins.readFile ./config.vim;
  cocConfig = builtins.readFile ./config-coc.vim;
  cocSettings = builtins.toJSON (import ./coc-settings.nix);
  spacemacs = builtins.readFile ./base16-spacemacs.vim;
  vimConfig = baseConfig + cocConfig + spacemacs;

in {
  home-manager.users.jobo.programs.neovim = {
    enable = true;
    extraConfig = vimConfig;
    plugins = myVimPlugins;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true; # for coc.nvim
    withPython3 = true; # for plugins
  };

  home-manager.users.jobo.xdg.configFile."nvim/coc-settings.json".text =
    cocSettings;

  home-manager.users.jobo.home.packages = with pkgs; [ jq ripgrep ];

}
