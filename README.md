# 🚀 My Neovim Configuration for Rust Development & Competitive Programming

A modern, feature-rich Neovim configuration optimized for Rust development and competitive programming. Built with Lazy.nvim plugin manager.

## 📋 Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Keymaps](#keymaps)
  - [General Navigation](#general-navigation)
  - [Window & Tab Management](#window--tab-management)
  - [LSP & Code Intelligence](#lsp--code-intelligence)
  - [Rust Development](#rust-development)
  - [Competitive Programming](#competitive-programming)
  - [Debugging](#debugging)
  - [Testing](#testing)
- [Plugin List](#plugin-list)
- [Workflow Guides](#workflow-guides)
  - [Solving a Competitive Programming Problem](#solving-a-competitive-programming-problem)
  - [Creating a New Rust Project](#creating-a-new-rust-project)
  - [Debugging Rust Code](#debugging-rust-code)
- [Snippets](#snippets)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)

## ✨ Features

- **Modern Rust Development** - Full LSP support with rust-analyzer, clippy integration
- **Competitive Programming** - Quick run, test with input files, benchmarking
- **Debugging** - Integrated DAP with codelldb
- **Testing** - Neotest integration for Rust tests
- **Autocompletion** - Smart completion with snippets
- **Syntax Highlighting** - Treesitter for all major languages
- **Git Integration** - Gitsigns for git blame and hunks
- **File Explorer** - Nvim-tree with git status
- **Fuzzy Finding** - Telescope for files, grep, and more

## 🛠️ Installation

### Prerequisites

- Neovim 0.9.0 or later
- Git
- Rust and Cargo (for Rust development)
- Node.js (for LSP servers)

### Quick Install

```bash
# Clone the configuration
git clone https://github.com/yourusername/nvim-config.git ~/.config/nvim

# Install Rust (if not installed)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install Rust components
rustup component add clippy rustfmt

# Install lazy.nvim (will auto-install on first run)
nvim --headless +Lazy! +qa

# Open Neovim to install plugins
nvim
```

The first launch will automatically install all plugins. Wait for the installation to complete.

## ⌨️ Keymaps

### General Navigation

| Keymap | Description |
|--------|-------------|
| `kj` | Exit insert mode (faster than ESC) |
| `<leader>nh` | Clear search highlights |
| `<leader>+` | Increment number under cursor |
| `<leader>-` | Decrement number under cursor |

### Window & Tab Management

| Keymap | Description |
|--------|-------------|
| `<leader>sv` | Split window vertically |
| `<leader>sh` | Split window horizontally |
| `<leader>se` | Make splits equal size |
| `<leader>sx` | Close current split |
| `<leader>to` | Open new tab |
| `<leader>tx` | Close current tab |
| `<leader>tn` | Go to next tab |
| `<leader>tp` | Go to previous tab |
| `<leader>tf` | Open current buffer in new tab |

### LSP & Code Intelligence

| Keymap | Description |
|--------|-------------|
| `K` | Show documentation/hover |
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gr` | Go to references |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Show code actions |
| `<leader>d` | Show diagnostic under cursor |
| `[d` | Go to previous diagnostic |
| `]d` | Go to next diagnostic |
| `<leader>dd` | Toggle inline diagnostics |

### Rust Development

| Keymap | Description |
|--------|-------------|
| `<leader>rt` | Show runnables (tests, binaries) |
| `<leader>rm` | Expand macro |
| `<leader>rp` | Go to parent module |
| `<leader>rc` | Open Cargo.toml |

### Competitive Programming

| Keymap | Description | Usage |
|--------|-------------|-------|
| `<leader>ic` | Input Create | Creates filename.in file for test input |
| `<leader>ir` | Input Run | Runs code with input from .in file |
| `<leader>rr` | Run Regular | Runs code normally (manual input) |
| `<leader>rb` | Run Build | Builds release binary |
| `<leader>rt` | Run Test | Runs cargo test |

### Debugging (DAP)

| Keymap | Description |
|--------|-------------|
| `<F5>` | Start/continue debugging |
| `<F10>` | Step over |
| `<F11>` | Step into |
| `<F12>` | Step out |
| `<leader>db` | Toggle breakpoint |
| `<leader>dr` | Open REPL |
| `<leader>du` | Toggle debug UI |

### Testing (Neotest)

| Keymap | Description |
|--------|-------------|
| `<leader>tt` | Run nearest test |
| `<leader>tf` | Run all tests in file |
| `<leader>ts` | Toggle test summary |

## 📦 Plugin List

| Category | Plugins |
|----------|---------|
| Plugin Manager | lazy.nvim |
| UI | nvim-tree, lualine, bufferline, telescope |
| LSP | nvim-lspconfig, mason.nvim, mason-lspconfig |
| Completion | nvim-cmp, LuaSnip, friendly-snippets |
| Rust | rustaceanvim |
| Debugging | nvim-dap, nvim-dap-ui |
| Testing | neotest, neotest-rust |
| Syntax | nvim-treesitter |
| Git | gitsigns.nvim |
| Editing | comment.nvim, vim-surround, vim-maximizer |

## 🎯 Workflow Guides

### Solving a Competitive Programming Problem

1. **Create a new Rust file**
   ```bash
   nvim problem_name.rs
   ```

2. **Write your solution (use snippets for speed)**
   - Type `main` + Tab for main function
   - Type `read` + Tab for input reading
   - Type `readm` + Tab for reading multiple values

3. **Create input file**
   ```
   <leader>ic
   ```
   This creates `problem_name.in` in a split window. Add your test input:
   ```
   2 7 11 15
   9
   ```

4. **Run with input**
   ```
   <leader>ir
   ```
   This opens a terminal and runs your code with the input file.

5. **Check output** - Should match expected result

6. **Iterate** - Edit input, save (`:w`), and run again (`<leader>ir`)

### Creating a New Rust Project

```bash
# Create Cargo project
cargo new my_project
cd my_project

# Open in Neovim
nvim src/main.rs

# Use keymaps:
# - Write code
# - `<leader>rr` to run
# - `<leader>rt` to show runnables
# - `<leader>rc` to open Cargo.toml
```

### Debugging Rust Code

1. **Set breakpoint**
   ```
   <leader>db
   ```

2. **Start debugging**
   ```
   <F5>
   ```

3. **Navigate**
   - `<F10>` - Step over
   - `<F11>` - Step into
   - `<F12>` - Step out

4. **View debug info**
   ```
   <leader>du
   ```
   Toggles debug UI showing variables, breakpoints, and stack trace.

## 📝 Snippets

Available Rust snippets (in `~/.config/nvim/snippets/rust.json`):

| Trigger | Expansion |
|---------|-----------|
| `main` | Complete main function |
| `read` | Read and parse single value |
| `readm` | Read multiple space-separated values |
| `for` | For loop |
| `pln` | println! macro |
| `vec` | Create vector |

### Example usage:

```rust
// Type 'main' + Tab
fn main() {
    // Type 'read' + Tab
    let mut input = String::new();
    std::io::stdin().read_line(&mut input).unwrap();
    let n: i32 = input.trim().parse().unwrap();
    
    // Type 'readm' + Tab
    let values: Vec<i32> = input
        .split_whitespace()
        .map(|x| x.parse().unwrap())
        .collect();
    
    // Type 'for' + Tab
    for i in 0..n {
        // code
    }
    
    // Type 'pln' + Tab
    println!("{}", result);
}
```

## 🔧 Troubleshooting

### Common Issues

**"No Cargo.toml found"**
- Create a Cargo project: `cargo new project_name`
- Or use quick run: `<leader>rx` (if configured)

**LSP not working**
- Run `:Mason` to check installed servers
- Install rust-analyzer: `:MasonInstall rust_analyzer`

**Debugger not working**
- Install codelldb: `:MasonInstall codelldb`
- Check configuration in `lua/setup/plugins/rust-tools.lua`

**Snippets not working**
- Ensure friendly-snippets is installed
- Run `:Lazy sync` to update

### Useful Commands

| Command | Description |
|---------|-------------|
| `:Lazy` | Open Lazy plugin manager |
| `:Mason` | Open Mason package manager |
| `:TSInstall` | Install treesitter parsers |
| `:checkhealth` | Check Neovim health |
| `:LspInfo` | Show LSP information |

## 🤝 Contributing

Feel free to fork and customize this configuration! Some ideas for improvements:

- Add more language support (Python, Go, JavaScript)
- Customize color scheme
- Add more snippets for competitive programming
- Create problem templates

## 📚 Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [Rust Analyzer](https://rust-analyzer.github.io/)
- [Competitive Programming in Rust](https://codeforces.com/blog/entry/74684)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)

## 📄 License

MIT License - Feel free to use and modify!

---

Happy Coding! 🦀🚀
