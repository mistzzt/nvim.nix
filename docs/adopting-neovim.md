# Adopting neovim: from VSCode habits to fluency

The config already covers everything needed to replace VSCode for the workflows in [nvim.md](nvim.md). The gap is not missing features, it is trying to absorb ~60 bindings at once. Adopt them in workflow-sized chunks, anchored to existing VSCode habits.

## VSCode reflex map

Every VSCode reflex has a direct equivalent. This is the highest-leverage table to internalize because it reuses existing muscle memory instead of building new:

| VSCode habit                     | Neovim equivalent                               |
| -------------------------------- | ----------------------------------------------- |
| Cmd+P quick open                 | `<C-p>`                                         |
| Cmd+Shift+F search in project    | `<leader>sg` live grep                          |
| F12 / Shift+F12 def / references | `grd` / `grr`                                   |
| F2 rename                        | `grn`                                           |
| Cmd+. quick fix                  | `gra`                                           |
| Cmd+Shift+O symbol in file       | `gO`                                            |
| Format document                  | `<leader>f`                                     |
| Problems panel                   | `<leader>sd` picker, or `]d`/`[d` to walk them  |
| Source Control diff view         | `<leader>do`                                    |
| Ctrl+Tab recent editors          | `<leader><leader>` buffers, `<leader>s.` recent |
| Cmd+F find in file               | `/`, or `<leader>/` for the fuzzy version       |

## Three phases, one week each

### Week 1: navigation only

`<C-p>`, `<leader>sg`, `<leader><leader>`, `<C-hjkl>`, and `grd`/`grr`. That is the entire "get around a codebase" loop. Ignore everything else. When something is forgotten, press `<leader>` and read the which-key popup, or `<leader>sk` to fuzzy-search all keymaps. That escape hatch means the cheatsheet never needs to be open.

### Week 2: the diff-review loop

The stated main use case, so it gets its own week. The core loop after an agent makes changes:

1. `<leader>do` opens diffview against the index, `Tab`/`S-Tab` walks files in the panel, `<leader>dc` closes. Inside the file panel, `-` (or `s`) stages the file under the cursor; for hunk-level staging, use gitsigns `<leader>hs` in the working-tree buffer.
2. Or the quickfix variant for fine-grained review: `<leader>hQ` dumps every hunk in the repo into quickfix, `:cn`/`:cp` walks them, `<leader>hp` previews, `<leader>hs` stages the good ones, `<leader>hr` rejects the bad ones.

Run the acceptance test from nvim.md: have an agent make a multi-file change and review plus stage it entirely in neovim. Three or four repetitions and this loop sticks.

### Week 3: editing polish

`grn`/`gra` on real refactors, `vih`/`dih` hunk textobjects, mini.surround (`saiw)`, `sd'`), and `]c`/`[c` for jumping hunks while editing.

## Tactics

**Shrink the cheatsheet.** [keybindings.md](keybindings.md) is a reference, not a learning tool. Keep a scratch note with just the current week's 5 or 6 bindings. Add one, drop one as they stick.

**Make VSCode slightly inconvenient, not forbidden.** VSCode stays enabled, but the rule is: agent-diff review and any edit on the dev hosts happens in neovim; VSCode is allowed only when genuinely stuck. The reconnect friction of VSCode Remote naturally enforces this on precision/van/swan.

## Expected gaps, by design

Known in advance so they do not read as breakage:

- **No file tree.** Deliberate (neo-tree is permanently out). `<C-p>`/`<leader>sf` replaces it, but the first week feels disorienting. For "what is in this directory", builtin `:Explore` (netrw) exists without adding anything; revisit the decision only if that proves insufficient.
- **No autopairs, no snippets.** Also deliberate. If typing closing brackets manually turns out to be real friction after a few weeks, that is exactly the "friction proves it necessary" trigger from the design doc.
- **No integrated terminal needed.** herdr panes are the terminal. `<Esc><Esc>` exits terminal mode if `:term` ever gets opened.

## herdr and tmux

Both use prefix `C-b`. herdr: `prefix ?` opens the keybinding help; `prefix n`/`prefix p` next/previous tab, `prefix 1..9` jump to tab, `prefix c` new tab, `prefix z` zoom, `prefix [` copy mode, `prefix hjkl` pane focus, `prefix w` workspace picker, `prefix g` goto picker. tmux-style rebinds and aliases: `prefix d` detach (replaces `prefix q`, which in tmux would mean "show pane numbers"), `prefix %` / `prefix "` split (defaults `prefix v` / `prefix -` still work). Direct chords (no prefix): `ctrl+alt+[`/`ctrl+alt+]` cycle tabs, `ctrl+alt+hjkl` pane focus. tmux (infra servers): vi copy mode, `prefix "` / `prefix %` split keeping cwd, `prefix hjkl` pane focus, `prefix r` reload config.

Because `C-b` is the prefix, neovim's page-back inside a session is `C-b C-b`; `C-u`/`C-d` half-page scrolls are unaffected.

## Neovim

Leader is space. which-key pops up on any prefix, so this lists only the load-bearing set.

### Core

| Binding      | Action                             |
| ------------ | ---------------------------------- |
| `<C-hjkl>`   | Window focus                       |
| `<C-p>`      | Git files picker (VSCode habit)    |
| `<leader>f`  | Format buffer (conform)            |
| `<leader>q`  | Diagnostics to location list       |
| `]d` / `[d`  | Next/prev diagnostic (opens float) |
| `<Esc>`      | Clear search highlight             |
| `<Esc><Esc>` | Exit terminal mode                 |
| Arrow keys   | Disabled in normal mode            |

### Search: `<leader>s*` (telescope)

| Binding             | Action                       |
| ------------------- | ---------------------------- |
| `<leader>sf`        | Files                        |
| `<leader>sg`        | Live grep                    |
| `<leader>sw`        | Grep word under cursor       |
| `<leader>sd`        | Diagnostics                  |
| `<leader>sr`        | Resume last picker           |
| `<leader>s.`        | Recent files                 |
| `<leader>sh` / `sk` | Help / keymaps               |
| `<leader>ss`        | All pickers                  |
| `<leader><leader>`  | Buffers                      |
| `<leader>/`         | Fuzzy find in current buffer |

### Git hunks: `<leader>h*` (gitsigns)

| Binding             | Action                                  |
| ------------------- | --------------------------------------- |
| `]c` / `[c`         | Next/prev hunk                          |
| `<leader>hs` / `hr` | Stage / reset hunk (also visual)        |
| `<leader>hS` / `hR` | Stage / reset buffer                    |
| `<leader>hp` / `hi` | Preview hunk float / inline             |
| `<leader>hq` / `hQ` | Hunks to quickfix: file / whole repo    |
| `<leader>hb`        | Blame line                              |
| `<leader>hd` / `hD` | Diff buffer against index / last commit |
| `vih`, `dih`        | Hunk textobject                         |

### Diffview: `<leader>d*`

| Binding      | Action                            |
| ------------ | --------------------------------- |
| `<leader>do` | Open diff against index           |
| `<leader>dr` | Open diff against a ref (prompts) |
| `<leader>dc` | Close                             |
| `<leader>df` | Current file history              |
| `<leader>dh` | Repo history                      |

### LSP: `gr*` and toggles

The `gr*` prefix is neovim 0.11's builtin default LSP namespace (`grn`, `grr`, `gra`, `gri`, `grt` ship with stock neovim; see `:h grr`). Mnemonic: [G]oto [R]eference-family actions on the symbol under the cursor, and the which-key popup for `gr` is labeled exactly that. The config keeps the stock keys and only upgrades their implementations to telescope pickers, so the muscle memory transfers to any vanilla neovim 0.11+.

| Binding             | Action                                   |
| ------------------- | ---------------------------------------- |
| `grd` / `grD`       | Definition / declaration                 |
| `grr` / `gri`       | References / implementation              |
| `grn` / `gra`       | Rename / code action                     |
| `grt`               | Type definition                          |
| `gO` / `gW`         | Document / workspace symbols             |
| `<leader>th`        | Toggle inlay hints                       |
| `<leader>tb` / `tw` | Toggle line blame / intra-line word diff |

### Completion (blink, insert mode)

| Binding           | Action                                         |
| ----------------- | ---------------------------------------------- |
| `<C-y>`           | Accept                                         |
| `<C-n>` / `<C-p>` | Next / previous item                           |
| `<C-l>`           | Open menu / toggle docs (not `<C-space>`: IME) |
| `<C-e>`           | Hide menu                                      |

### Textobjects and surround (mini)

`aa`/`ii` next argument-style textobjects (remapped off `an`/`in`, which stay builtin incremental selection). `saiw)` surround word, `sd'` delete surrounding quotes, `sr)'` replace. Note `s` substitute is shadowed; use `cl`.
