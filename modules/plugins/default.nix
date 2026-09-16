{
  imports = [
    ./blink.nix
    ./conform.nix
    ./diagnostics.nix
    ./diffview.nix
    ./git.nix
    ./lsp.nix
    ./orgmode.nix
    ./telescope.nix
    ./treesitter.nix
  ];

  plugins = {
    which-key = {
      enable = true;

      settings = {
        delay = 0;

        spec = [
          {
            __unkeyed-1 = "<leader>t";
            group = "[T]oggle";
          }
        ];
      };
    };

    guess-indent.enable = true;

    todo-comments = {
      enable = true;
      settings.signs = false;
    };

    mini = {
      enable = true;

      # stand in for nvim-web-devicons, which plugins expect but kickstart drops
      mockDevIcons = true;

      modules = {
        ai = {
          n_lines = 500;
          search_method = "cover_or_next";

          # off an/in, which are builtin incremental selection
          mappings.around_next = "aa";
          mappings.inside_next = "ii";
        };
        icons = {};
        surround = {};
        statusline.use_icons = true;
      };
    };
  };
}
