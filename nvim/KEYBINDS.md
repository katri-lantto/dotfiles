# Neovim Keybinds Cheat Sheet

> **Leader key:** `Space`

---

## File Explorer (Neo-tree)

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle explorer open / close |
| `<leader>o` | Focus explorer |
| `<leader>E` | Reveal current file in explorer |

### Inside the tree

| Key | Action |
|-----|--------|
| `<CR>` | Open file |
| `s` | Open in vertical split |
| `S` | Open in horizontal split |
| `t` | Open in new tab |
| `P` | Toggle file preview float |
| `l` | Focus preview |
| `a` | Add file or directory |
| `r` | Rename |
| `d` | Delete |
| `y` | Copy to clipboard |
| `x` | Cut to clipboard |
| `p` | Paste from clipboard |
| `c` | Copy (in-tree) |
| `m` | Move |
| `z` | Collapse all nodes |
| `Z` | Expand all nodes |
| `R` | Refresh tree |
| `q` | Close tree |
| `?` | Show help |

---

## LSP (Language Server)

> Active in any buffer with an LSP attached.

### Navigation

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | References |
| `gi` | Go to implementation |
| `K` | Hover documentation |

### Actions

| Key | Action |
|-----|--------|
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>f` | Format buffer |

### Diagnostics

| Key | Action |
|-----|--------|
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<leader>d` | Show diagnostic float |

---

## Mason

| Command | Action |
|---------|--------|
| `:Mason` | Open Mason UI (browse / install / update) |
| `:MasonUpdate` | Update Mason registry |

---

## General Vim (built-in)

### Windows / Splits

| Key | Action |
|-----|--------|
| `<C-w>h/j/k/l` | Move between splits (left/down/up/right) |
| `<C-w>s` | Horizontal split |
| `<C-w>v` | Vertical split |
| `<C-w>q` | Close split |
| `<C-w>=` | Equalise split sizes |

### Tabs

| Key | Action |
|-----|--------|
| `gt` | Next tab |
| `gT` | Previous tab |
| `:tabnew` | New tab |
| `:tabclose` | Close tab |

### Navigation

| Key | Action |
|-----|--------|
| `gg` / `G` | Top / bottom of file |
| `<C-d>` / `<C-u>` | Half-page down / up |
| `%` | Jump to matching bracket |
| `*` / `#` | Search word under cursor (fwd / bwd) |
| `<C-o>` / `<C-i>` | Jump back / forward in jump list |

### Editing

| Key | Action |
|-----|--------|
| `u` / `<C-r>` | Undo / redo |
| `ciw` / `diw` | Change / delete inner word |
| `yi"` / `di"` | Yank / delete inside quotes |
| `>` / `<` | Indent / dedent (visual mode) |
| `~` | Toggle case of character |

---

## Tmux

> **Prefix:** `Ctrl-a` (not the default `Ctrl-b`)

### Sessions

| Key | Action |
|-----|--------|
| `prefix + $` | Rename session |
| `prefix + s` | List / switch sessions |
| `prefix + d` | Detach from session |
| `tmux ls` | List sessions (from shell) |
| `tmux attach -t <name>` | Attach to session (from shell) |

### Windows

| Key | Action |
|-----|--------|
| `prefix + c` | New window |
| `prefix + n` | Next window |
| `prefix + p` | Previous window |
| `prefix + 0-9` | Switch to window by number |
| `prefix + w` | Browse / switch windows interactively |
| `prefix + ,` | Rename window |

### Panes

| Key | Action |
|-----|--------|
| `prefix + &` | Split pane horizontally (side by side) |
| `prefix + %` | Split pane vertically (top / bottom) |
| `Alt + ←/→/↑/↓` | Switch panes **without prefix** |
| `prefix + x` | Kill current pane |
| `prefix + z` | Toggle pane fullscreen zoom |
| `prefix + {` / `}` | Swap pane left / right |

### Copy mode (tmux-yank)

| Key | Action |
|-----|--------|
| `prefix + [` | Enter copy mode |
| `v` | Begin selection (in copy mode) |
| `y` | Yank selection to clipboard |
| `q` | Exit copy mode |

### Misc

| Key | Action |
|-----|--------|
| `prefix + r` | Reload tmux config |
| `prefix + Ctrl-s` | Save session (tmux-resurrect) |
| `prefix + Ctrl-r` | Restore session (tmux-resurrect) |
