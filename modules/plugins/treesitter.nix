{config, ...}: {
  dependencies = {
    # gcc breaks on darwin and grammarPackages makes it unneeded
    # https://github.com/nix-community/nixvim/issues/1282
    gcc.enable = false;
  };

  plugins.treesitter = {
    enable = true;

    highlight.enable = true;
    indent.enable = true;

    grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
      bash
      c
      diff
      html
      json
      lua
      make
      markdown
      markdown_inline
      query
      regex
      toml
      vim
      vimdoc
      xml
      yaml
      gitignore
      gitcommit
      gitattributes
      git_rebase
      dockerfile
    ];
  };
}
