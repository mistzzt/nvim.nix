{pkgs, ...}: {
  # no nixvim module; the plugin registers `:LivePreview` itself and needs no setup()
  extraPlugins = [pkgs.vimPlugins.live-preview-nvim];

  # the server serves any file under cwd, so a switched-to buffer only needs its URL echoed
  autoCmd = [
    {
      event = "BufEnter";
      pattern = ["*.md" "*.markdown"];
      desc = "Print the live-preview URL for the entered markdown file";
      callback.__raw = ''
        function(args)
          if not require('livepreview').is_running() then return end
          local rel = vim.fs.relpath(vim.uv.cwd(), vim.api.nvim_buf_get_name(args.buf))
          if not rel then
            vim.notify('live-preview.nvim: file is outside cwd, restart the preview to view it', vim.log.levels.WARN)
            return
          end
          local config = require('livepreview.config').config
          print(('live-preview.nvim: http://%s:%d/%s'):format(config.address, config.port, vim.uri_encode(rel)))
        end
      '';
    }
  ];

  keymaps = [
    {
      mode = "n";
      key = "<leader>tm";
      # take the first free port from 3000 up so concurrent nvims never share one
      action.__raw = ''
        function()
          if require('livepreview').is_running() then
            vim.cmd('LivePreview close')
            return
          end
          local port = 3000
          while true do
            local tcp = vim.uv.new_tcp()
            -- EADDRINUSE may only surface at listen(), so probe both
            local ok = tcp:bind('127.0.0.1', port) and tcp:listen(1, function() end)
            tcp:close()
            if ok then break end
            port = port + 1
          end
          -- `true` is a no-op browser: OrbStack isolation breaks xdg-open, so open the echoed URL on the host
          require('livepreview.config').set({ port = port, browser = 'true' })
          vim.cmd('LivePreview start')
        end
      '';
      options.desc = "[T]oggle [m]arkdown preview";
    }
  ];
}
