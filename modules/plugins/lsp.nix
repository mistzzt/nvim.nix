let
  telescopeAction = builtin: {
    __raw = "require('telescope.builtin').${builtin}";
  };

  lspKeyMap = {
    mode ? "n",
    key,
    action,
    desc,
  }: {
    inherit mode key action;
    options.desc = "LSP: ${desc}";
  };
in {
  plugins.lspconfig.enable = true;
  plugins.fidget.enable = true;

  lsp.keymaps = [
    (lspKeyMap {
      key = "grn";
      action.__raw = "vim.lsp.buf.rename";
      desc = "[R]e[n]ame";
    })

    (lspKeyMap {
      mode = ["n" "x"];
      key = "gra";
      action.__raw = "vim.lsp.buf.code_action";
      desc = "[G]oto Code [A]ction";
    })

    # not goto definition: in C this lands on the header
    (lspKeyMap {
      key = "grD";
      action.__raw = "vim.lsp.buf.declaration";
      desc = "[G]oto [D]eclaration";
    })

    (lspKeyMap {
      key = "grr";
      action = telescopeAction "lsp_references";
      desc = "[G]oto [R]eferences";
    })

    (lspKeyMap {
      key = "gri";
      action = telescopeAction "lsp_implementations";
      desc = "[G]oto [I]mplementation";
    })

    (lspKeyMap {
      key = "grd";
      action = telescopeAction "lsp_definitions";
      desc = "[G]oto [D]efinition";
    })

    (lspKeyMap {
      key = "grt";
      action = telescopeAction "lsp_type_definitions";
      desc = "[G]oto [T]ype Definition";
    })

    (lspKeyMap {
      key = "gO";
      action = telescopeAction "lsp_document_symbols";
      desc = "Open Document Symbols";
    })

    (lspKeyMap {
      key = "gW";
      action = telescopeAction "lsp_dynamic_workspace_symbols";
      desc = "Open Workspace Symbols";
    })
  ];

  lsp.onAttach = ''
    -- highlight other references to the symbol under a resting cursor,
    -- and clear them again once it moves
    if client:supports_method('textDocument/documentHighlight', bufnr) then
      local highlight_augroup = vim.api.nvim_create_augroup('nixvim-lsp-highlight', { clear = false })

      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = bufnr,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = bufnr,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('nixvim-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'nixvim-lsp-highlight', buffer = event2.buf }
        end,
      })
    end

    -- inlay hints displace code, so they stay off behind a toggle
    if client:supports_method('textDocument/inlayHint', bufnr) then
      vim.keymap.set('n', '<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr })
      end, { buffer = bufnr, desc = 'LSP: [T]oggle Inlay [H]ints' })
    end
  '';
}
