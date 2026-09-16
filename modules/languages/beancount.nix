{config, ...}: {
  filetype.extension.bean = "beancount";

  lsp.servers.beancount.enable = true;

  plugins.treesitter.grammarPackages = [
    config.plugins.treesitter.package.builtGrammars.beancount
  ];
}
