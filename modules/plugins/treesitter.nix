{config, ...}: {
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
