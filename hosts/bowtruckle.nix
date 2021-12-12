{ pkgs, lib, ... }:

{

  networking.hostName = "bowtruckle";
  system.stateVersion = 4;
  services = {
    nix-daemon.enable = true;
    # pam.enableSudoTouchIdAuth = true;
  };
  nix = {
    package = pkgs.nix;
    extraOptions = ''
      system = aarch64-darwin
      extra-platforms = aarch64-darwin x86_64-darwin
      sandbox = false
      experimental-features = nix-command flakes
      build-users-group = nixbld
    '';
    trustedUsers = [ "jobo" ];
    binaryCaches = [
      "https://nix-community.cachix.org/"
      "https://hydra.iohk.io"
      "https://iohk.cachix.org"
    ];
    binaryCachePublicKeys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      "iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo="
    ];
  };
}
