{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.services.kmonad;

in {

  options = {
    services.kmonad = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          If enabled, run kmonad after boot.
        '';
      };

      configfiles = mkOption {
        type = types.listOf types.path;
        default = [ ];
        example = "[ my-config.kbd ]";
        description = ''
          Config files for dedicated kmonad instances.
        '';
      };

      package = mkOption {
        type = types.package;
        default = pkgs.kmonad;
        example = "pkgs.kmonad";
        description = ''
          The kmonad package.
        '';
      };
    };
  };

  config = {
    environment.systemPackages = [ cfg.package ];

    security.accessibilityPrograms = [ "${cfg.package}/bin/kmonad" ];

    launchd.daemons = let
      # prettify the service's name by taking the config filename..
      conf-file = kbd-path:
        lists.last (strings.splitString "/" (toString kbd-path));
      # ...and dropping the extension
      conf-name = conf-file: lists.head (strings.splitString "." conf-file);

      mk-kmonad-service = kbd-path: {
        "kmonad-${conf-name kbd-path}" = {
          description = "KMonad Instance for: " + conf-name kbd-path;
          command = "${pkgs.package}/bin/kmonad -M  ${kbd-path}";

          serviceConfig = {
            Restart = "always";
            RestartSec = 3;
            Nice = -20;
            RunAtLoad = true;
          };
        };
      };
    in lib.fold (kbd-path: acc: acc // mk-kmonad-service kbd-path) { }
    cfg.configfiles;
  };

}
