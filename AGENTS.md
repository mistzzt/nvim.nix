# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A standalone [nixvim](https://github.com/nix-community/nixvim) configuration flake, shared between machines and consumed by per-machine (personal / work) flakes either via home-manager's `programs.nixvim` or standalone via `evalNixvim`. The config is derived from kickstart.nvim; comments in the modules typically explain intentional deviations from it.

## Commands

```bash
nix run .          # build and launch the configured neovim
nix flake check    # nixvim's headless smoke test (catches invalid options / broken config at build time)
nix build          # build the package without running it
```

There is no separate lint or test suite; `nix flake check` is the verification step after any module change. Nix files are formatted with alejandra.

## Architecture

- `flake.nix` deliberately has **no `nixpkgs` input**: it builds against the nixpkgs pin from `nixvim.inputs`, which nixvim's generated plugin options are CI-tested against. Do not add a `nixpkgs` input or a `nixpkgs.follows` override, and preserve this property when advising consumers.
- `nixvimModules.default` (= `./modules`) is the real output: **prefix-free** nixvim modules, meaning options are written bare (`plugins.foo`, `opts`, `keymaps`) so they import equally under `programs.nixvim` (a submodule) or directly into `evalNixvim`. Keep new modules prefix-free.
- `packages.<system>.default` and `checks.<system>.default` are both derived from a single `evalNixvim` call on those modules (`config.build.package` and `config.build.test`).

### Module layout

- `modules/default.nix`: imports everything, plus aliases and colorscheme.
- `modules/options.nix`, `modules/keymaps.nix`: vim options and plugin-independent keymaps.
- `modules/plugins/default.nix`: imports the per-plugin modules and holds small plugins not worth their own file (which-key groups, mini.nvim, treesitter grammars).
- `modules/plugins/<name>.nix`: one file per substantial plugin (lsp, telescope, blink completion, conform formatting, gitsigns, diffview, diagnostics).

### Conventions

- Keymaps are declared through a small local `keyMap` / `lspKeyMap` helper let-binding in each file that needs one, always with an `options.desc` (kickstart-style `[S]earch [F]iles` mnemonic descriptions, matching the which-key group prefixes defined in `modules/plugins/default.nix`).
- Lua is embedded via `__raw` (or `on_attach` / `onAttach` strings) rather than `extraConfigLua`.
- Formatter and LSP binaries are pinned to nix store paths with `lib.getExe pkgs.<tool>` instead of relying on `$PATH` (see `conform.nix`, `lsp.nix`).
- New leader-key prefixes should get a which-key `spec` group entry in `modules/plugins/default.nix`.
