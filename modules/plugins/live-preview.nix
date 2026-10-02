{pkgs, ...}: {
  # no nixvim module; the plugin registers `:LivePreview` itself and needs no setup()
  extraPlugins = [pkgs.vimPlugins.live-preview-nvim];

  keymaps = [
    {
      mode = "n";
      key = "<leader>tm";
      # bind a kernel-assigned free port on each start so concurrent nvims never share one
      action.__raw = ''
        function()
          if require('livepreview').is_running() then
            vim.cmd('LivePreview close')
            return
          end
          local tcp = vim.uv.new_tcp()
          tcp:bind('127.0.0.1', 0)
          -- `true` is a no-op browser: OrbStack isolation breaks xdg-open, so open the echoed URL on the host
          require('livepreview.config').set({ port = tcp:getsockname().port, browser = 'true' })
          tcp:close()
          vim.cmd('LivePreview start')
        end
      '';
      options.desc = "[T]oggle [m]arkdown preview";
    }
  ];
}
