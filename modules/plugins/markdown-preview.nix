{
  plugins.markdown-preview = {
    enable = true;

    settings = {
      auto_start = 1;
      # reuse one preview page across markdown buffers; requires auto_close off
      combine_preview = 1;
      auto_close = 0;
      # no local browser in the VM: open the echoed URL on the host instead
      echo_preview_url = 1;
      port = "8080";
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>tm";
      action = "<cmd>MarkdownPreviewToggle<CR>";
      options.desc = "[T]oggle [m]arkdown preview";
    }
  ];
}
