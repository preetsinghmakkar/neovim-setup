# Neovim Command Reference

> Leader key = `Space` | Escape = `kj` (in insert/terminal mode)

---

## Table of Contents

1. [Core Navigation](#core-navigation)
2. [Window & Split Management](#window--split-management)
3. [Buffer & Tab Management](#buffer--tab-management)
4. [File Explorer](#file-explorer)
5. [Fuzzy Finding (Telescope)](#fuzzy-finding-telescope)
6. [Harpoon — Fast File Jumping](#harpoon--fast-file-jumping)
7. [Flash — Fast Motion](#flash--fast-motion)
8. [LSP (Language Server)](#lsp-language-server)
9. [Rust Development](#rust-development)
10. [Competitive Programming](#competitive-programming)
11. [Debugging (DAP)](#debugging-dap)
12. [Testing (Neotest)](#testing-neotest)
13. [Cargo.toml (Crates.nvim)](#cargotoml-cratesnvim)
14. [Git Integration](#git-integration)
15. [Search & Replace](#search--replace)
16. [Code Formatting & Linting](#code-formatting--linting)
17. [Terminal (ToggleTerm)](#terminal-toggleterm)
18. [Diagnostics & Trouble](#diagnostics--trouble)
19. [Completion (nvim-cmp)](#completion-nvim-cmp)
20. [Surround & Substitute](#surround--substitute)
21. [Treesitter Text Objects](#treesitter-text-objects)
22. [TODO Comments](#todo-comments)
23. [Session Management](#session-management)
24. [Rust Snippets Reference](#rust-snippets-reference)
25. [Vim Fundamentals Cheatsheet](#vim-fundamentals-cheatsheet)

---

## Core Navigation

| Key | Action |
|-----|--------|
| `kj` | Exit insert mode (your ESC) |
| `<C-d>` | Scroll half-page down (cursor stays centered) |
| `<C-u>` | Scroll half-page up (cursor stays centered) |
| `n` / `N` | Next/prev search match (centered) |
| `J` | Join line below (cursor stays) |
| `<leader>nh` | Clear search highlights |
| `<leader>+` / `<leader>-` | Increment / decrement number |
| `<leader>j` | **Flash jump** — type 2 chars, pick label |
| `<leader>J` | **Flash treesitter** — select by syntax node |

### Visual Mode
| Key | Action |
|-----|--------|
| `J` | Move selection down |
| `K` | Move selection up |
| `<leader>p` | Paste without overwriting yank register |
| `<leader>y` | Yank to system clipboard |
| `<leader>D` | Delete to void register (no yank pollution) |

---

## Window & Split Management

| Key | Action |
|-----|--------|
| `<leader>sv` | Split vertically |
| `<leader>sh` | Split horizontally |
| `<leader>se` | Equalize split sizes |
| `<leader>sx` | Close current split |
| `<leader>sm` | Maximize / restore split (vim-maximizer) |
| `<C-h/j/k/l>` | Navigate between splits |
| `<C-Up/Down>` | Resize split height |
| `<C-Left/Right>` | Resize split width |

---

## Buffer & Tab Management

| Key | Action |
|-----|--------|
| `<S-h>` | Previous buffer |
| `<S-l>` | Next buffer |
| `<leader>bd` | Delete (close) current buffer |
| `<leader>Tn` | New tab |
| `<leader>Tx` | Close tab |
| `<leader>T.` / `<leader>T,` | Next / prev tab |
| `<leader>Tb` | Open current buffer in new tab |

> Note: tabs use `<leader>T*` (capital T) so that `<leader>t*` (lowercase) is free for testing.

---

## File Explorer

| Key | Action |
|-----|--------|
| `<leader>ee` | Toggle NvimTree |
| `<leader>ef` | Reveal current file in NvimTree |

### Inside NvimTree
| Key | Action |
|-----|--------|
| `a` | Create file/directory |
| `d` | Delete |
| `r` | Rename |
| `x` | Cut |
| `c` | Copy |
| `p` | Paste |
| `y` | Copy filename |
| `Y` | Copy relative path |
| `gy` | Copy absolute path |
| `Enter` / `o` | Open |
| `v` | Open in vertical split |
| `s` | Open in horizontal split |
| `I` | Toggle hidden files |
| `H` | Toggle dotfiles |
| `R` | Refresh |
| `q` | Close NvimTree |

---

## Fuzzy Finding (Telescope)

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files in project |
| `<leader>fr` | Find recent files |
| `<leader>fs` | Live grep (search text in project) |
| `<leader>fc` | Grep word under cursor |
| `<leader>ft` | Find TODO/FIXME/HACK comments |

### Inside Telescope
| Key | Action |
|-----|--------|
| `<C-j>` / `<C-k>` | Move up/down |
| `<C-q>` | Send results to quickfix list |
| `<Esc>` / `kj` | Close |
| `<CR>` | Open selected |
| `<C-v>` | Open in vertical split |
| `<C-x>` | Open in horizontal split |

---

## Harpoon — Fast File Jumping

Mark your most-visited files (e.g., `src/main.rs`, `Cargo.toml`, `tests/`) and jump between them instantly.

| Key | Action |
|-----|--------|
| `<leader>ha` | Add current file to harpoon list |
| `<leader>hh` | Open harpoon quick-menu |
| `<leader>1` | Jump to harpoon slot 1 |
| `<leader>2` | Jump to harpoon slot 2 |
| `<leader>3` | Jump to harpoon slot 3 |
| `<leader>4` | Jump to harpoon slot 4 |
| `<leader>hn` | Next harpoon file |
| `<leader>hp` | Prev harpoon file |

> **Workflow for large codebases**: Add `main.rs`, `lib.rs`, key module files, and `Cargo.toml` → use `<leader>1-4` to fly between them.

---

## Flash — Fast Motion

| Key | Mode | Action |
|-----|------|--------|
| `<leader>j` | n/v/o | Jump to any visible position |
| `<leader>J` | n/v/o | Jump + select by treesitter node |
| `r` | o | Remote flash (operate on distant text) |
| `R` | o/v | Treesitter search (for operators) |
| `f/F/t/T` | n | Enhanced with jump labels on repeat |

---

## LSP (Language Server)

Works in any buffer with an attached LSP (Rust, TS, Solidity, etc.).

| Key | Action |
|-----|--------|
| `K` | Hover documentation |
| `gd` | Go to definition → opens in **Trouble** panel (press `q` or `<leader>xc` to close) |
| `gD` | Go to declaration (single result, no panel) |
| `gi` | Go to implementation → opens in **Trouble** panel |
| `gr` | List all references → opens in **Trouble** panel |
| `gy` | Go to type definition → opens in **Trouble** panel |
| `<leader>rn` | Rename symbol across all files |
| `<leader>ca` | Code actions |
| `<leader>d` | Show diagnostic float for current line |
| `[d` / `]d` | Prev / next diagnostic |
| `<leader>dd` | Toggle inline virtual text diagnostics |
| `<leader>dl` | Send diagnostics to location list |

---

## Rust Development

All `<leader>r*` keys are buffer-local to `.rs` files.

| Key | Action |
|-----|--------|
| `<leader>rt` | Show all runnables (tests, binaries, examples) via Telescope |
| `<leader>rR` | Re-run last runnable |
| `<leader>rm` | Expand macro under cursor |
| `<leader>rp` | Navigate to parent module |
| `<leader>rc` | Open `Cargo.toml` for current crate |
| `<leader>re` | Explain error under cursor (rust-analyzer) |
| `<leader>ro` | Open docs.rs for symbol under cursor |
| `<leader>ri` | Toggle inlay hints (type/param annotations) |
| `<leader>ru` | Move item up (struct field, enum variant) |
| `<leader>rd` | Move item down |
| `<leader>ca` | Code actions (Rust-enhanced) |
| `K` | Hover docs + actions panel |
| `<leader>rr` | `cargo run --release` in terminal |
| `<leader>rb` | `cargo build --release` in terminal |
| `<leader>rk` | `cargo check` (fast type/borrow check) |
| `<leader>rl` | `cargo clippy` lint |

> **Inlay hints** show type annotations inline — great when reading unfamiliar Rust code. Toggle with `<leader>ri`.

---

## Competitive Programming

| Key | Action |
|-----|--------|
| `<leader>ic` | Create `<file>.in` input file (opens in vsplit) |
| `<leader>ir` | Run with input file: `cargo run --release < file.in` |
| `<leader>rr` | Run without input: `cargo run --release` |
| `<leader>rb` | Build release binary |
| `<leader>cp` | Insert CP solution template (fast I/O boilerplate) |

### CP Workflow
1. `<leader>cp` — insert fast I/O template into empty `main.rs`
2. Write your solution in `solve()`
3. `<leader>ic` — create `solution.in`, paste your test input
4. `<leader>ir` — compile + run with input, see output in terminal
5. `<leader>rR` — re-run quickly after changes (uses last runnable)

### Useful CP Snippets (type prefix in insert mode)
| Snippet | What it gives you |
|---------|-------------------|
| `cpmain` | Full CP main with buffered I/O |
| `cpmt` | Multi-test-case main |
| `readv` | Read space-separated values as `Vec<i64>` |
| `parsev` | Parse whitespace tokens from `&str` |
| `parse2` | Parse 2 values from a line |
| `bsearchc` | Custom binary search template |
| `uf` | Union-Find (DSU) with path compression |
| `dijkstra` | Dijkstra shortest path |
| `bfs` | BFS shortest path |
| `dfs` | DFS iterative |
| `modpow` | Modular exponentiation |
| `prefix` | Build prefix sum array |
| `minheap` | Min-heap (BinaryHeap + Reverse) |
| `maxheap` | Max-heap (BinaryHeap) |
| `entry` | HashMap counter increment |

---

## Debugging (DAP)

| Key | Action |
|-----|--------|
| `<F5>` | Continue / start debugging |
| `<F10>` | Step over |
| `<F11>` | Step into |
| `<F12>` | Step out |
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Set conditional breakpoint |
| `<leader>du` | Toggle DAP UI (variables, stack, watches) |
| `<leader>dr` | Open REPL |
| `<leader>dq` | Terminate debug session |

### Debug Workflow (Rust)
1. `cargo build` first (needs an executable)
2. `<leader>db` — set breakpoint on the line you care about
3. `<F5>` — choose "Launch (debug)", enter executable path
4. Step through with `F10/F11/F12`, inspect variables in DAP UI
5. `<leader>dq` — done

> Variable values are shown **inline** in the code as virtual text while debugging.

---

## Testing (Neotest)

| Key | Action |
|-----|--------|
| `<leader>tt` | Run test nearest to cursor |
| `<leader>tf` | Run all tests in current file |
| `<leader>ts` | Toggle test summary panel |
| `<leader>to` | Open test output |
| `<leader>tD` | Debug nearest test (runs test under DAP) |
| `]T` | Jump to next failed test |
| `[T` | Jump to prev failed test |

---

## Cargo.toml (Crates.nvim)

These keys only activate when you're in `Cargo.toml`:

| Key | Action |
|-----|--------|
| `<leader>ct` | Toggle crate version info inline |
| `<leader>cv` | Show available versions popup |
| `<leader>cf` | Show features popup |
| `<leader>cd` | Show dependencies popup |
| `<leader>cu` | Update crate to latest |
| `<leader>cU` | Update ALL crates |
| `<leader>cx` | Expand to inline table format |
| `<leader>cX` | Extract to separate `[dependencies]` table |
| `<leader>co` | Open crates.io page |
| `<leader>ch` | Open crate homepage |
| `<leader>cr` | Open crate repository |

---

## Git Integration

### Gitsigns (inline hunk actions)
| Key | Action |
|-----|--------|
| `]h` | Next hunk |
| `[h` | Prev hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hS` | Stage entire buffer |
| `<leader>hR` | Reset entire buffer |
| `<leader>hu` | Undo staged hunk |
| `<leader>hp` | Preview hunk diff |
| `<leader>hb` | Blame current line (full) |
| `<leader>hB` | Toggle line blame (always visible) |
| `<leader>hd` | Diff this file |
| `<leader>hD` | Diff against `~` (last commit) |
| `ih` | Text object: select hunk (use with `v`, `d`, `y`, etc.) |

### LazyGit
| Key | Action |
|-----|--------|
| `<leader>lg` | Open LazyGit UI |

### DiffView
| Key | Action |
|-----|--------|
| `<leader>gd` | Open diff view (working tree vs HEAD) |
| `<leader>gh` | File history (current file) |
| `<leader>gH` | Full repo/branch history |
| `<leader>gc` | Close diff view |
| `<leader>gD` | Diff against specific branch/commit |

---

## Search & Replace

| Key | Action |
|-----|--------|
| `<leader>sr` | **Project-wide search & replace** (grug-far) |
| `<leader>sw` | Search word under cursor (project-wide) |
| `<leader>sf` | Search & replace in current file only |

> Uses ripgrep under the hood — fast even in huge codebases like the Linux kernel or Tokio.

---

## LeetCode (kawre/leetcode.nvim)

> Launch: `nvim leetcode.nvim` — see **LEETCODE.md** for the full guide.

| Key | Action |
|-----|--------|
| `<leader>lc` | Open LeetCode dashboard |
| `<leader>lcq` | Browse problem list (Telescope) |
| `<leader>lcy` | Today's daily challenge |
| `<leader>lct` | Open problem tabs |
| `<leader>lca` | Set auth cookie — runs `:Leet cookie update` |
| `<leader>lcx` | Sign out |
| `<leader>lcm` | Random problem |
| `<leader>lco` | Open current problem in browser |

**Inside a problem buffer:**

| Key | Action |
|-----|--------|
| `<leader>lcr` | Run test cases |
| `<leader>lcs` | Submit solution |
| `<leader>lcd` | Toggle description panel |
| `<leader>lcc` | Toggle console (test I/O) |
| `<leader>lci` | Problem info (difficulty, tags) |
| `<leader>lcl` | Switch language |

---

## Code Formatting & Linting

| Key | Action |
|-----|--------|
| `<leader>mp` | Format file (or visual selection) |
| `<leader>L` | Trigger linting manually |

**Auto-format on save** is enabled for all supported filetypes.

| Key | Action |
|-----|--------|
| `<leader>mp` | Format file (or visual selection) |
| `<leader>L` | Trigger linting manually |

| Language | Formatter | Linter |
|----------|-----------|--------|
| Rust | `rustfmt` | `clippy` (via rust-analyzer) |
| TypeScript / JS | `prettier` | `eslint_d` |
| Solidity | `prettier` | `solhint` |
| Lua | `stylua` | — |
| Python | `isort` + `black` | `pylint` |
| C / C++ | `clang-format` | — |
| Go | `gofmt` | — |

---

## Terminal (ToggleTerm)

> Terminal uses `<leader>T*` (capital T) namespace.

| Key | Action |
|-----|--------|
| `<C-\>` | Toggle horizontal terminal |
| `<leader>TF` | Toggle floating terminal |
| `<leader>TV` | Toggle vertical terminal (good for CP: code left, output right) |
| `<leader>TL` | Send current line to terminal |
| `<leader>TL` (visual) | Send selection to terminal |
| `kj` | Exit terminal mode (back to normal) |
| `<C-h/j/k/l>` | Navigate from terminal to splits |

---

## Diagnostics & Trouble

| Key | Action |
|-----|--------|
| `<leader>xw` | Workspace diagnostics (Trouble) |
| `<leader>xd` | Document diagnostics (Trouble) |
| `<leader>xq` | Quickfix list (Trouble) |
| `<leader>xl` | Location list (Trouble) |
| `<leader>xt` | TODOs in Trouble |
| `<leader>xc` | **Close all panels** — closes Trouble + quickfix + loclist from ANY window |
| `<leader>dd` | Toggle inline virtual text |
| `<leader>dl` | Send to location list |
| `<leader>d` | Float diagnostic for current line |

> **Closing the Trouble/Definitions panel:**
> - `<leader>xc` — closes from anywhere (no need to focus the panel)
> - `q` or `Esc` — closes when cursor is inside the panel
> - `gd` again — toggles it closed (same key that opened it)

---

## Completion (nvim-cmp)

| Key | Action |
|-----|--------|
| `<C-Space>` | Trigger completion manually |
| `<C-j>` / `<C-k>` | Navigate completion menu |
| `<C-b>` / `<C-f>` | Scroll documentation |
| `<CR>` | Confirm selection |
| `<Tab>` | Select next / expand snippet |
| `<S-Tab>` | Select prev / jump back in snippet |
| `<C-e>` | Abort / close completion |

---

## Surround & Substitute

### Surround (nvim-surround)
| Key | Action |
|-----|--------|
| `ys<motion><char>` | Add surround (e.g., `ysiw"` wraps word in `"`) |
| `ds<char>` | Delete surround |
| `cs<old><new>` | Change surround |
| `S<char>` | Surround visual selection |

**Examples:**
- `ysiw"` → surround word with `"`
- `ysa'"` → change `'` to `"`
- `ds"` → delete surrounding `"`
- `ysip)` → surround paragraph with `()`

### Substitute (substitute.nvim)
| Key | Action |
|-----|--------|
| `s<motion>` | Substitute with motion (paste register) |
| `ss` | Substitute entire line |
| `S` | Substitute to end of line |
| `s` (visual) | Substitute selection |

---

## Treesitter Text Objects

Powerful code selection for reading/editing codebases.

| Key | Mode | Selects |
|-----|------|---------|
| `af` / `if` | v/d/y | Outer / inner **function** |
| `ac` / `ic` | v/d/y | Outer / inner **class** |
| `aa` / `ia` | v/d/y | Outer / inner **parameter** |
| `ab` / `ib` | v/d/y | Outer / inner **block** |
| `]m` / `[m` | n | Next / prev function start |
| `]M` / `[M` | n | Next / prev function end |
| `]]` / `[[` | n | Next / prev class |
| `<CR>` | v | Expand selection (incremental) |
| `<BS>` | v | Shrink selection |

**Examples:**
- `daf` — delete entire function
- `yif` — yank function body
- `cac` — change entire class
- `]m` — jump to next function (great for skimming large files)

---

## TODO Comments

| Key | Action |
|-----|--------|
| `]t` | Jump to next TODO/FIXME/HACK comment |
| `[t` | Jump to prev TODO/FIXME/HACK comment |
| `<leader>ft` | List all TODOs in project (Telescope) |
| `<leader>xt` | All TODOs in Trouble panel |

**Tag types**: `TODO`, `FIXME`, `HACK`, `WARN`, `NOTE`, `PERF`, `TEST`

---

## Session Management

| Key | Action |
|-----|--------|
| `<leader>wr` | Restore session for current directory |
| `<leader>ws` | Save current session |

---

## Rust Snippets Reference

Type these prefixes in insert mode inside a `.rs` file:

| Prefix | Description |
|--------|-------------|
| `cpmain` | CP main with buffered I/O |
| `cpmt` | Multi-test-case CP main |
| `main` | Simple main function |
| `mainq` | Main with `?` operator (Result) |
| `read1` | Read single value from stdin |
| `readv` | Read space-separated Vec from stdin |
| `parsev` | Parse whitespace tokens from `&str` |
| `parse2` | Parse 2 values from a line |
| `fori` | For loop (range) |
| `fore` | For loop with enumerate |
| `pln` | `println!` |
| `dbg` | Debug print to stderr |
| `vecn` | New empty Vec |
| `vecc` | Vec with capacity |
| `vecf` | Vec filled with value |
| `vec2d` | 2D Vec (grid) |
| `hmap` | HashMap |
| `entry` | HashMap entry counter |
| `maxheap` | Max heap |
| `minheap` | Min heap (Reverse) |
| `bmap` | BTreeMap (sorted) |
| `bset` | BTreeSet (sorted unique) |
| `deque` | VecDeque |
| `sort` | Sort ascending (unstable) |
| `sortd` | Sort descending |
| `sortk` | Sort by key |
| `bsearch` | Binary search |
| `bsearchc` | Custom binary search template |
| `gcd` | GCD function |
| `lcm` | LCM function |
| `modpow` | Modular exponentiation |
| `prefix` | Prefix sum array |
| `uf` | Union-Find (DSU) |
| `graph` | Adjacency list graph |
| `bfs` | BFS shortest path |
| `dfs` | DFS iterative |
| `dijkstra` | Dijkstra shortest paths |
| `strimpl` | Struct with impl block |
| `display` | impl Display trait |
| `result` | Result type alias |

---

## Vim Fundamentals Cheatsheet

### Motions
| Key | Move to |
|-----|---------|
| `w` / `b` | Next / prev word start |
| `e` / `ge` | Next / prev word end |
| `W` / `B` | Next / prev WORD (whitespace-separated) |
| `0` / `^` | Line start (col 0) / first non-blank |
| `$` | Line end |
| `gg` / `G` | File start / end |
| `{` / `}` | Prev / next blank line |
| `%` | Jump to matching bracket |
| `f<c>` / `F<c>` | Jump to char (forward/back on line) |
| `t<c>` / `T<c>` | Jump before char (forward/back) |
| `;` / `,` | Repeat f/t (forward/back) |
| `<C-o>` / `<C-i>` | Jump back / forward in jump list |
| `''` | Jump to last position |
| `ma` / `'a` | Set mark `a` / jump to mark `a` |

### Operators (combine with motions/text objects)
| Key | Action |
|-----|--------|
| `d` | Delete |
| `c` | Change (delete + insert) |
| `y` | Yank (copy) |
| `v` | Visual select |
| `=` | Auto-indent |
| `>` / `<` | Indent / dedent |
| `g~` / `gU` / `gu` | Toggle / upper / lower case |

### Editing
| Key | Action |
|-----|--------|
| `i` / `a` | Insert before / after cursor |
| `I` / `A` | Insert at line start / end |
| `o` / `O` | New line below / above |
| `s` | Substitute char (delete + insert) |
| `r<c>` | Replace single char |
| `R` | Enter replace mode |
| `u` / `<C-r>` | Undo / redo |
| `.` | Repeat last change (very powerful) |
| `~` | Toggle case |
| `xp` | Swap two chars |
| `ddp` | Move line down |
| `ddkP` | Move line up |

### Registers
| Key | Action |
|-----|--------|
| `"<reg>y` | Yank into register |
| `"<reg>p` | Paste from register |
| `"+y` / `"+p` | System clipboard yank / paste |
| `"0p` | Paste from yank register (not affected by delete) |
| `:reg` | Show all registers |

### Macros
| Key | Action |
|-----|--------|
| `qa` | Record macro into register `a` |
| `q` | Stop recording |
| `@a` | Replay macro `a` |
| `@@` | Replay last macro |
| `5@a` | Replay macro `a` 5 times |

### Search & Replace (command mode)
| Command | Action |
|---------|--------|
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `:%s/old/new/g` | Replace all in file |
| `:%s/old/new/gc` | Replace all with confirmation |
| `:5,10s/old/new/g` | Replace in lines 5-10 |
| `:'<,'>s/old/new/g` | Replace in visual selection |

---

*Generated for: Rust / TypeScript / Solidity / GitHub workflow*
*Neovim config at: `~/.config/nvim/`*
