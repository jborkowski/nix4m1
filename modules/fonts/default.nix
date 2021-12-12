{ config, lib, pkgs, ... }:

{
  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [
      overpass
      fira
      fira-code-symbols
      fira-code
      emacs-all-the-icons-fonts
      (pkgs.callPackage ./sf-mono-liga-bin.nix { })
    ];
  };
}
