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

  # over ssh, copy via OSC 52 but paste the last copy locally: multiplexers like herdr never
  # answer OSC 52 reads, and which-key's `"` popup would block on one unless named "OSC 52"
  globals.clipboard.__raw = ''
    (function()
      if not (vim.env.SSH_CONNECTION or vim.env.SSH_TTY) then
        return nil
      end
      local osc52 = require('vim.ui.clipboard.osc52')
      local copied = { ['+'] = {}, ['*'] = {} }
      local function copy(reg)
        local send = osc52.copy(reg)
        return function(lines, regtype)
          copied[reg] = { lines, regtype }
          send(lines)
        end
      end
      local function paste(reg)
        return function() return copied[reg] end
      end
      return {
        name = 'OSC 52',
        copy = { ['+'] = copy('+'), ['*'] = copy('*') },
        paste = { ['+'] = paste('+'), ['*'] = paste('*') },
      }
    end)()
  '';

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
