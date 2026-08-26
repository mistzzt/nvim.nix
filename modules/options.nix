{
  autoGroups.nvim-highlight-yank.clear = true;

  autoCmd = [
    {
      event = "TextYankPost";
      group = "nvim-highlight-yank";
      desc = "Highlight when yanking text";
      callback.__raw = "function() vim.hl.on_yank() end";
    }
  ];

  opts = {
    number = true;
    relativenumber = true;
    mouse = "a";

    # disable showmode as it's already in the status line
    showmode = false;

    breakindent = true;
    linebreak = true;

    undofile = true;

    ignorecase = true;
    smartcase = true;

    signcolumn = "yes";

    # decreased so the which-key popup shows sooner
    updatetime = 250;
    timeoutlen = 300;

    splitright = true;
    splitbelow = true;

    list = true;
    listchars = "tab:»·,trail:·,extends:→,precedes:←,nbsp:␣";

    cursorline = true;
    inccommand = "split";

    hidden = true;

    scrolloff = 10;

    # prompt to save instead of failing on :q with unsaved changes
    confirm = true;
  };
}
