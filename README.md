# nvim.nix

Shared [nixvim](https://github.com/nix-community/nixvim) configuration, usable standalone or layered under home-manager. Serves as the common base for per-machine (personal / work) tweaks.

## Try it

```bash
nix run .          # launch the configured neovim
nix flake check    # nixvim's headless smoke test
```

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
