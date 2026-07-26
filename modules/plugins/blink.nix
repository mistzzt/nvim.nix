{
  plugins.blink-cmp = {
    enable = true;

    settings = {
      # <C-y> accept, <C-n>/<C-p> cycle, <C-l> menu/docs, <C-e> hide
      keymap = {
        preset = "default";
        # menu/docs on <C-l> instead of <C-space>, which is the IME toggle
        "<C-space>" = [];
        "<C-l>" = ["show" "show_documentation" "hide_documentation"];
      };

      # no snippets source: snippets are out of scope
      sources.default = ["lsp" "path"];

      # kickstart uses lua only to avoid a build step; nix provides the
      # prebuilt rust matcher
      fuzzy.implementation = "prefer_rust_with_warning";

      completion.documentation = {
        auto_show = true;
        auto_show_delay_ms = 500;
      };

      signature.enabled = true;
    };
  };
}
