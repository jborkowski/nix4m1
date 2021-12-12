{ pkgs, lib, home-manager, ... }:
let
  emacsSyncScript = pkgs.writeScriptBin "doom-sync-git" ''
    #!${pkgs.runtimeShell}
    export PATH=$PATH:${lib.makeBinPath [ pkgs.git pkgs.sqlite pkgs.unzip ]}
    if [ ! -d $HOME/.emacs.d/.git ]; then
      mkdir -p $HOME/.emacs.d
      git -C $HOME/.emacs.d init
    fi
    if [ $(git -C $HOME/.emacs.d rev-parse HEAD) != ${pkgs.doomEmacsRevision} ]; then
      git -C $HOME/.emacs.d fetch https://github.com/hlissner/doom-emacs.git || true
      git -C $HOME/.emacs.d checkout ${pkgs.doomEmacsRevision} || true
    fi
  '';
  langs = [
    "bash"
    "c"
    "cpp"
    "css"
    "nix"
    "lua"
    "html"
    "rust"
    "yaml"
    "toml"
    "make"
    "json"
    "fish"
    "regex"
    "elisp"
    "fennel"
    "comment"
    "markdown"
    "clojure"
  ];
  grammars = lib.getAttrs (map (lang: "tree-sitter-${lang}") langs) pkgs.tree-sitter.builtGrammars;
in
{
  home-manager.users.jobo.home.packages = with pkgs; [
    ((emacsPackagesNgGen emacs).emacsWithPackages
      (epkgs: [ epkgs.vterm ]))
    (ripgrep.override { withPCRE2 = true; })
    fd
    sqlite
    gnuplot
    pandoc

    (aspellWithDicts (ds: with ds; [ pl en en-computers en-science ]))
    tectonic
    emacsSyncScript

    neovim-nightly

    tree-sitter
  ];
  home-manager.users.jobo.home.file.".config/tree-sitter".source = (pkgs.runCommand "grammars" {} ''
    mkdir -p $out/bin
    ${lib.concatStringsSep "\n"
      (lib.mapAttrsToList (name: src: "name=${name}; ln -s ${src}/parser $out/bin/\${name#tree-sitter-}.so") grammars)};
  '');

}
