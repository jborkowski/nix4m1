{ config, lib, pkgs, ... }:

{
  home-manager.users.jobo.programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    userName = "Jonatan Borkowski";
    userEmail = "jonatan.borkowski@pm.me";
    ignores = [
      "#*#"
      "*.a"
      "*.aux"
      "*.dylib"
      "*.elc"
      "*.glob"
      "*.la"
      "*.o"
      "*.so"
      "*.v.d"
      "*.vo"
      "*~"
      ".clean"
      ".direnv"
      ".envrc"
      ".envrc.override"
      ".ghc.environment.x86_64-darwin-*"
      ".makefile"
      "TAGS"
      "cabal.project.local"
      "dist-newstyle"
      "result"
      "result-*"
      "tags"
    ];
    aliases = {
      amend = "commit --amend -C HEAD";
      co = "checkout";
      ci = "commit";
      s = "status";
      st = "status";
      d = "diff";
      pr = "pull --rebase";
      l =
        "log --graph --pretty='%Cred%h%Creset - %C(bold blue)<%an>%Creset %s%C(yellow)%d%Creset %Cgreen(%cr)' --abbrev-commit --date=relative";
    };
    extraConfig = {
      core.editor = "nvim";
      protocol.keybase.allow = "always";
      submodule = { recurse = true; };
    };
  };
}
