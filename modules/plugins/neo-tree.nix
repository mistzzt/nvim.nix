{
  plugins.neo-tree = {
    enable = true;
    settings = {
      # Setup reads this before merging defaults; explicit false avoids a startup log warning.
      log_to_file = false;
      filesystem.window.mappings."\\" = "close_window";
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "\\";
      action = "<cmd>Neotree reveal<CR>";
      options = {
        desc = "Neo-tree reveal current file";
        silent = true;
      };
    }
  ];
}
