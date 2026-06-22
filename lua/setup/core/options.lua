vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- line numbers
opt.relativenumber = false   -- absolute numbers (matches target aesthetic)
opt.number = true

-- tabs & indentation
opt.tabstop = 4       -- Rust standard: 4 spaces
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- line wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- cursor
opt.cursorline = true
opt.scrolloff = 8      -- keep 8 lines above/below cursor when scrolling
opt.sidescrolloff = 8

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.colorcolumn = ""     -- no column guide (was visually cluttering the window)
opt.showmode = false      -- mode is shown in lualine

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

-- performance
opt.updatetime = 50     -- faster CursorHold (default 4000ms)
opt.timeoutlen = 300    -- which-key triggers faster

-- undo (persistent across sessions — very useful for large codebases)
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undodir"
opt.undolevels = 10000

-- no swap/backup (use undofile instead)
opt.swapfile = false
opt.backup = false

-- completion
opt.completeopt = "menuone,noselect"
opt.pumheight = 10    -- limit completion menu height

-- misc
opt.isfname:append("@-@")  -- treat @ as part of filenames
opt.shortmess:append("c")  -- no completion messages
opt.conceallevel = 0        -- show `` in markdown files

-- ensure undo dir exists
vim.fn.mkdir(vim.fn.stdpath("data") .. "/undodir", "p")
