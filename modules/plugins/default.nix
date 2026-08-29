{config, ...}: {
  imports = [
    ./blink.nix
    ./conform.nix
    ./diagnostics.nix
    ./diffview.nix
    ./git.nix
    ./lsp.nix
    ./orgmode.nix
    ./telescope.nix
  ];

  dependencies = {
    # gcc breaks on darwin and grammarPackages makes it unneeded
    # https://github.com/nix-community/nixvim/issues/1282
    gcc.enable = false;
  };

  plugins = {
    which-key = {
      enable = true;

      settings = {
        delay = 0;

        spec = [
          {
            __unkeyed-1 = "<leader>s";
            group = "[S]earch";
          }
          {
            __unkeyed-1 = "<leader>t";
            group = "[T]oggle";
          }
          {
            __unkeyed-1 = "<leader>h";
            group = "Git [H]unk";
            mode = ["n" "v"];
          }
          {
            __unkeyed-1 = "gr";
            group = "LSP ([G]oto [R]eference)";
            mode = "n";
          }
          {
            __unkeyed-1 = "<leader>d";
            group = "[D]iffview";
          }
          {
            __unkeyed-1 = "<leader>o";
            group = "[O]rg";
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

    treesitter = {
      enable = true;

      highlight.enable = true;
      indent.enable = true;

      grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
        bash
        beancount
        c
        diff
        html
        json
        lua
        make
        markdown
        markdown_inline
        nix
        python
        query
        regex
        toml
        vim
        vimdoc
        xml
        yaml
        gitignore
        gitcommit
        gitattributes
        git_rebase
        dockerfile
      ];
    };
  };
}
