{
  pkgs,
  lib,
  ...
}: {
  plugins.conform-nvim = {
    enable = true;

    settings = {
      notify_on_error = false;

      # no format-on-save: formatting is explicit, via <leader>f
      format_on_save = null;

      default_format_opts.lsp_format = "fallback";

      formatters_by_ft = {
        nix = ["alejandra"];
        python = ["ruff_format"];
      };

      # point at the nix-provided binaries rather than relying on $PATH
      formatters = {
        alejandra.command = lib.getExe pkgs.alejandra;
        ruff_format.command = lib.getExe pkgs.ruff;
      };
    };
  };

  keymaps = [
    {
      mode = ["n" "v"];
      key = "<leader>f";
      action.__raw = "function() require('conform').format { async = true } end";
      options.desc = "[F]ormat buffer";
    }
  ];
}
