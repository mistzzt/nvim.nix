{
  config,
  pkgs,
  lib,
  ...
}: {
  # nixd evaluates the flake, so it can complete NixOS/home-manager
  # option names and jump to their definitions
  lsp.servers.nixd = {
    enable = true;
    config.settings.nixd.formatting.command = ["${lib.getExe pkgs.alejandra}"];
  };

  plugins.conform-nvim.settings = {
    formatters_by_ft.nix = ["alejandra"];
    formatters.alejandra.command = lib.getExe pkgs.alejandra;
  };

  plugins.treesitter.grammarPackages = [
    config.plugins.treesitter.package.builtGrammars.nix
  ];
}
