{
  plugins.which-key.settings.spec = [
    {
      __unkeyed-1 = "<leader>s";
      group = "[S]earch";
    }
  ];

  plugins.telescope = {
    enable = true;
    keymaps = {
      "<leader>sf" = {
        action = "find_files";
        options.desc = "[S]earch [F]iles";
      };

      "<leader>sh" = {
        action = "help_tags";
        options.desc = "[S]earch Neovim [H]elp";
      };

      "<leader>sk" = {
        action = "keymaps";
        options.desc = "[S]earch Neovim [K]eymaps";
      };

      "<leader>ss" = {
        action = "builtin";
        options.desc = "[S]earch [S]elect Telescope";
      };

      "<leader>sd" = {
        action = "diagnostics";
        options.desc = "[S]earch [D]iagnostics";
      };

      "<leader>sr" = {
        action = "resume";
        options.desc = "[S]earch [R]esume";
      };

      "<leader>s." = {
        action = "oldfiles";
        options.desc = "[S]earch Recent Files (\".\" for repeat)";
      };

      "<leader><leader>" = {
        action = "buffers";
        options.desc = "[ ] Find existing buffers";
      };

      "<leader>sg" = {
        action = "live_grep";
        options.desc = "[S]earch by [G]rep";
      };

      "<leader>sw" = {
        action = "grep_string";
        mode = ["n" "v"];
        options.desc = "[S]earch current [W]ord";
      };

      "<C-p>" = "git_files";
    };
    extensions = {
      fzf-native.enable = true;
      ui-select.enable = true;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>/";
      action.__raw = ''
        function()
          require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false,
          })
        end
      '';
      options.desc = "[/] Fuzzily search in current buffer";
    }
  ];
}
