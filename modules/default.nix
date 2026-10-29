{
  imports = [
    ./options.nix
    ./keymaps.nix
    ./languages
    ./plugins
  ];

  viAlias = true;
  vimAlias = true;

  colorschemes.catppuccin = {
    enable = true;
    settings = {
      flavour = "auto";
      background = {
        light = "latte";
        dark = "mocha";
      };
    };
  };

  # catch theme changes missed while detached from a multiplexer
  autoGroups.nvim-requery-background.clear = true;
  autoCmd = [
    {
      event = "FocusGained";
      group = "nvim-requery-background";
      desc = "Re-query the terminal background color";
      callback.__raw = "function() vim.api.nvim_ui_send('\\027]11;?\\007') end";
    }
  ];
}
