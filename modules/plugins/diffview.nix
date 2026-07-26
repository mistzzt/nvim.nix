let
  keyMap = {
    key,
    action,
    desc,
  }: {
    mode = "n";
    inherit key action;
    options.desc = desc;
  };
in {
  plugins.diffview.enable = true;

  keymaps = [
    (keyMap {
      key = "<leader>do";
      action = "<cmd>DiffviewOpen<CR>";
      desc = "[D]iffview [o]pen against index";
    })

    (keyMap {
      key = "<leader>dr";
      # no <CR>: leaves the cmdline open to type a ref
      action = ":DiffviewOpen ";
      desc = "[D]iffview open against a [r]ef";
    })

    (keyMap {
      key = "<leader>dc";
      action = "<cmd>DiffviewClose<CR>";
      desc = "[D]iffview [c]lose";
    })

    (keyMap {
      key = "<leader>df";
      action = "<cmd>DiffviewFileHistory %<CR>";
      desc = "[D]iffview current [f]ile history";
    })

    (keyMap {
      key = "<leader>dh";
      action = "<cmd>DiffviewFileHistory<CR>";
      desc = "[D]iffview repo [h]istory";
    })
  ];
}
