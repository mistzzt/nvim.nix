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
  diagnostic.settings = {
    update_in_insert = false;
    severity_sort = true;

    float = {
      border = "rounded";
      source = "if_many";
    };

    underline.severity.min.__raw = "vim.diagnostic.severity.WARN";

    virtual_text = {
      source = "if_many";
      spacing = 2;
    };

    # open the float on ]d / [d so the message is readable without a second keypress
    jump.on_jump.__raw = ''
      function(_, bufnr)
        vim.diagnostic.open_float { bufnr = bufnr, scope = 'cursor', focus = false }
      end
    '';
  };

  keymaps = [
    (keyMap {
      key = "<leader>q";
      action.__raw = "vim.diagnostic.setloclist";
      desc = "Open diagnostic [Q]uickfix list";
    })
  ];
}
