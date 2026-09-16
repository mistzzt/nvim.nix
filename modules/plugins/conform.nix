{
  plugins.conform-nvim = {
    enable = true;

    settings = {
      notify_on_error = false;

      # no format-on-save: formatting is explicit, via <leader>f
      format_on_save = null;

      default_format_opts.lsp_format = "fallback";
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
