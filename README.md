# nvim.nix

Shared [nixvim](https://github.com/nix-community/nixvim) configuration, usable standalone or layered under home-manager. Serves as the common base for per-machine (personal / work) tweaks. The config is derived from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) as a starting point. There is no mason and no plugin manager; nix provides all binaries and plugins, and formatter/LSP executables are pinned to store paths rather than resolved from `$PATH`.

## Try it

```bash
nix run .          # launch the configured neovim
nix flake check    # nixvim's headless smoke test
```

## Plugins

| Plugin                 | What it is                                                                                                                                                        |
| ---------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **diffview.nvim**      | Repo-level diff browser: side-by-side diff of the whole working tree with a file panel, plus commit/file history. The main use case: reviewing agent-produced diffs |
| **gitsigns.nvim**      | Git status in the gutter and hunk operations: stage, reset, preview, blame, navigate `]c`/`[c`, plus an `ih` hunk textobject and quickfix listing                   |
| **blink.cmp**          | Autocompletion engine: popup menu as you type, fed by LSP and path sources, with signature help                                                                    |
| **nvim-lspconfig**     | Ready-made configs for talking to language servers; provides rename, code action, go-to-definition, references                                                     |
| **fidget.nvim**        | Small floating notifications showing LSP progress (indexing, loading workspace)                                                                                    |
| **conform.nvim**       | Formatter runner: dispatches buffer/range to an external formatter per filetype (alejandra for nix, ruff for python)                                               |
| **telescope.nvim**     | Fuzzy finder over anything: files, git files, live grep, buffers, help, diagnostics, LSP symbols. fzf-native speeds up matching; ui-select routes vim's builtin pickers through it |
| **nvim-treesitter**    | Incremental parser giving accurate syntax highlighting and indentation from real grammars, not regex                                                               |
| **todo-comments.nvim** | Highlights `TODO`/`FIXME`/`HACK`/`NOTE` in comments and makes them searchable; useful for finding agent-left markers                                               |
| **orgmode.nvim**       | Org-mode editing and task management, with agenda files under `~/personal/orbit`, inbox capture, custom TODO states, and per-file archives                         |
| **mini.ai**            | Extra textobjects: `vaf` function, `ciq` quotes, argument objects, etc.                                                                                            |
| **mini.surround**      | Add/change/delete surrounding pairs: `saiw)` surround word, `sd'` delete quotes, `sr)'` replace                                                                    |
| **mini.statusline**    | Minimal statusline: mode, file, git branch, diagnostics, position                                                                                                  |
| **mini.icons**         | File-type icons for pickers and statusline (mocks web-devicons for plugins that expect it)                                                                         |
| **guess-indent.nvim**  | Detects an existing file's indentation and sets buffer options to match                                                                                            |
| **which-key.nvim**     | After pressing a prefix (e.g. `<leader>`), pops up a panel of available continuations with descriptions                                                            |
| **catppuccin/nvim**    | Colorscheme: latte when the terminal background is light, mocha when dark                                                                                          |

## Outputs

- `nixvimModules.default`: prefix-free nixvim modules (the actual config)
- `packages.<system>.default`: the base config built standalone via `evalNixvim`
- `checks.<system>.default`: nixvim's build-time smoke test

## Consuming

Add as an input:

```nix
nvim-nix.url = "github:mistzzt/nvim.nix";
```

Don't add a `nixpkgs.follows` override: the config intentionally builds against nixvim's own pinned nixpkgs, which its generated plugin options are CI-tested against.

### Via home-manager's `programs.nixvim`

`programs.nixvim` is a submodule, so the prefix-free modules import cleanly under it and machine-specific tweaks layer alongside:

```nix
programs.nixvim = {
  enable = true;
  imports = [inputs.nvim-nix.nixvimModules.default];

  # machine-specific tweaks
  plugins.lsp.servers.gopls.enable = true;
};
```

### Standalone (no home-manager)

```nix
home.packages = [inputs.nvim-nix.packages.${system}.default];
```

Or extend without home-manager via `evalNixvim`:

```nix
(inputs.nixvim.lib.evalNixvim {
  inherit system;
  modules = [
    inputs.nvim-nix.nixvimModules.default
    ./my-tweaks.nix
  ];
}).config.build.package
```
