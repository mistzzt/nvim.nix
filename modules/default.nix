{
  imports = [
    ./options.nix
    ./keymaps.nix
    ./languages
    ./plugins
  ];

  viAlias = true;
  vimAlias = true;

  colorschemes.catppuccin = {
    enable = true;
    settings = {
      flavour = "auto";
      background = {
        light = "latte";
        dark = "mocha";
      };
    };
  };
}
