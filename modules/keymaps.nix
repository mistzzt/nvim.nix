let
  keyMap = {
    mode ? "n",
    key,
    action,
    desc,
  }: {
    inherit mode key action;
    options.desc = desc;
  };
in {
  globals = {
    mapleader = " ";
    maplocalleader = " ";
  };

  keymaps = [
    (keyMap {
      key = "<Esc>";
      action = "<cmd>nohlsearch<CR>";
      desc = "Clear highlights on search";
    })

    (keyMap {
      mode = "t";
      key = "<Esc><Esc>";
      action = "<C-\\><C-n>";
      desc = "Exit terminal mode";
    })

    # <C-hjkl> rather than <leader>hjkl: <leader>h is the gitsigns hunk prefix,
    # so a leader-based window jump would stall for timeoutlen every time
    (keyMap {
      key = "<C-h>";
      action = "<C-w><C-h>";
      desc = "Move focus to the left window";
    })

    (keyMap {
      key = "<C-l>";
      action = "<C-w><C-l>";
      desc = "Move focus to the right window";
    })

    (keyMap {
      key = "<C-j>";
      action = "<C-w><C-j>";
      desc = "Move focus to the bottom window";
    })

    (keyMap {
      key = "<C-k>";
      action = "<C-w><C-k>";
      desc = "Move focus to the top window";
    })

    (keyMap {
      key = "<Up>";
      action = "<cmd>echoerr 'Use k to move up'<CR>";
      desc = "Move cursor up";
    })

    (keyMap {
      key = "<Down>";
      action = "<cmd>echoerr 'Use j to move down'<CR>";
      desc = "Move cursor down";
    })

    (keyMap {
      key = "<Left>";
      action = "<cmd>echoerr 'Use h to move left'<CR>";
      desc = "Move cursor left";
    })

    (keyMap {
      key = "<Right>";
      action = "<cmd>echoerr 'Use l to move right'<CR>";
      desc = "Move cursor right";
    })
  ];
}
