{
  "languageserver" = {
    "dhall" = {
      "command" = "dhall-lsp-server";
      "filetypes" = [ "dhall" ];
    };

    "haskell" = {
      "command" = "haskell-language-server-wrapper";
      "args" = [ "--lsp" ];
      "rootPatterns" = [
        "stack.yaml"
        "hie.yaml"
        ".hie-bios"
        "BUILD.bazel"
        ".cabal"
        "cabal.project"
        "package.yaml"
      ];
      "filetypes" = [ "hs" "lhs" "haskell" ];
    };

    "nix" = {
      "command" = "rnix-lsp";
      "filetypes" = [ "nix" ];
    };

    "purescript" = {
      "command" = "purescript-language-server";
      "args" = [ "--stdio" ];
      "filetypes" = [ "purescript" ];
      "trace.server" = "off";
      "rootPatterns" = [ "bower.json" "psc-package.json" "spago.dhall" ];
      "settings" = {
        "purescript" = {
          "addSpagoSources" = true;
          "addNpmPath" =
            true; # Set to true if using a local purty install for formatting
        };
      };
    };
  };

  "yank.highlight.duration" = 700;
}
