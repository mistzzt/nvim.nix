{config, ...}: {
  filetype.extension.bean = "beancount";

  lsp.servers.beancount = {
    enable = true;
    config.init_options.journal_file = "~/personal/bcac/main.bean";
  };

  plugins.treesitter.grammarPackages = [
    config.plugins.treesitter.package.builtGrammars.beancount
  ];
}
