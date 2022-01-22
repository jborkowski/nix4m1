{ pkgs, lib, home-manager, ... }:
{
  home-manager.users.jobo.home.packages = with pkgs; [
    ((emacsPackagesNgGen emacs).emacsWithPackages (epkgs: [ epkgs.vterm ]))
    (ripgrep.override { withPCRE2 = true; })
    fd
    sqlite
    gnuplot
    pandoc

    (aspellWithDicts (ds: with ds; [ pl en en-computers en-science ]))
    neovim-nightly
    tectonic

    tree-sitter
  ];

  services.emacs = {
    enable = true;
    package = pkgs.emacs;
  };

}
