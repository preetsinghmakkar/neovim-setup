-- set leader key to space (must be FIRST)
vim.g.mapleader = " "

local keymap = vim.keymap

---------------------
-- General Keymaps
---------------------

-- save file
keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
keymap.set("i", "<C-s>", "<Esc><cmd>w<CR>", { desc = "Save file" })

-- kj exits insert mode (your primary escape)
keymap.set("i", "kj", "<ESC>", { desc = "Exit insert mode" })

-- clear search highlights
keymap.set("n", "<leader>nh", "<cmd>nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- move lines up/down in visual mode
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- keep cursor centered when jumping half-page
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (centered)" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (centered)" })

-- keep cursor centered when searching
keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
keymap.set("n", "N", "Nzzzv", { desc = "Prev search result (centered)" })

-- paste without overwriting register (great for replacing words)
keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without overwriting register" })

-- yank to system clipboard explicitly
keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })

-- delete to void register (don't pollute yank with deletions)
keymap.set({ "n", "v" }, "<leader>D", '"_d', { desc = "Delete to void register" })

-- better join line (keep cursor in place)
keymap.set("n", "J", "mzJ`z", { desc = "Join line (cursor stays)" })

---------------------
-- Window Navigation (essential for split workflow)
---------------------

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equalize splits" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })
-- Close ALL panels (Trouble + native quickfix/loclist) from any window
keymap.set("n", "<leader>xc", "<cmd>Trouble close<CR><cmd>cclose<CR><cmd>lclose<CR>", { desc = "Close Trouble/quickfix/loclist" })

-- navigate between splits with Ctrl+hjkl
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom split" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top split" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })

-- resize splits
keymap.set("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase split height" })
keymap.set("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease split height" })
keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease split width" })
keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase split width" })

---------------------
-- Buffer Navigation
---------------------

keymap.set("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
keymap.set("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

---------------------
-- Tabs
---------------------

-- <leader>t* is reserved for testing (neotest) — tabs use <leader>T* (capital)
keymap.set("n", "<leader>Tn", "<cmd>tabnew<CR>", { desc = "New tab" })
keymap.set("n", "<leader>Tx", "<cmd>tabclose<CR>", { desc = "Close tab" })
keymap.set("n", "<leader>T.", "<cmd>tabn<CR>", { desc = "Next tab" })
keymap.set("n", "<leader>T,", "<cmd>tabp<CR>", { desc = "Previous tab" })
keymap.set("n", "<leader>Tb", "<cmd>tabnew %<CR>", { desc = "Open buffer in new tab" })

---------------------
-- Rust / Competitive Programming
---------------------

-- Create input file for CP (side by side)
keymap.set("n", "<leader>ic", function()
	local file = vim.fn.expand("%:r")
	local input_file = file .. ".in"

	if vim.fn.filereadable(input_file) == 0 then
		local f = io.open(input_file, "w")
		if f then
			f:write("")
			f:close()
			print("Created: " .. input_file)
		end
	else
		print("Already exists: " .. input_file)
	end

	vim.cmd("vsplit " .. input_file)
end, { desc = "[CP] Create/open input file" })

-- Run with input file (shows output in split terminal)
keymap.set("n", "<leader>ir", function()
	local file = vim.fn.expand("%:r")
	local input_file = file .. ".in"
	vim.cmd("w")

	if vim.fn.filereadable(input_file) == 0 then
		print("No input file. Use <leader>ic to create one.")
		return
	end

	local ft = vim.bo.filetype
	if ft == "rust" then
		vim.cmd("split | terminal cargo run --release < " .. input_file)
	elseif ft == "cpp" then
		vim.cmd("split | terminal clang++ % -O2 -std=c++20 -o " .. file .. " && ./" .. file .. " < " .. input_file)
	elseif ft == "go" then
		vim.cmd("split | terminal go run % < " .. input_file)
	else
		print("No runner configured for: " .. ft)
	end
end, { desc = "[CP] Run with input file" })

-- Run normally (no input redirect)
keymap.set("n", "<leader>rr", function()
	vim.cmd("w")
	local ft = vim.bo.filetype

	if ft == "rust" then
		vim.cmd("split | terminal cargo run --release")
	elseif ft == "cpp" then
		local file = vim.fn.expand("%:r")
		vim.cmd("split | terminal clang++ % -O2 -std=c++20 -o " .. file .. " && ./" .. file)
	elseif ft == "go" then
		vim.cmd("split | terminal go run %")
	else
		print("No runner configured for: " .. ft)
	end
end, { desc = "Run current file" })

-- Build release binary
keymap.set("n", "<leader>rb", function()
	vim.cmd("w")
	if vim.bo.filetype == "rust" then
		vim.cmd("split | terminal cargo build --release")
	end
end, { desc = "[Rust] Build release" })

-- Cargo check (fast, no full build)
keymap.set("n", "<leader>rk", function()
	vim.cmd("w")
	if vim.bo.filetype == "rust" then
		vim.cmd("split | terminal cargo check")
	end
end, { desc = "[Rust] Cargo check" })

-- Cargo clippy (linting)
keymap.set("n", "<leader>rl", function()
	vim.cmd("w")
	if vim.bo.filetype == "rust" then
		vim.cmd("split | terminal cargo clippy -- -W clippy::all")
	end
end, { desc = "[Rust] Run Clippy" })

-- New CP solution template
keymap.set("n", "<leader>cp", function()
	local template = [[use std::io::{self, BufRead, Write};

fn solve(input: &[&str]) -> String {
    // TODO: parse input and solve
    let _n: i64 = input[0].trim().parse().unwrap();
    String::new()
}

fn main() {
    let stdin = io::stdin();
    let stdout = io::stdout();
    let mut out = io::BufWriter::new(stdout.lock());

    let lines: Vec<String> = stdin.lock().lines().map(|l| l.unwrap()).collect();
    let refs: Vec<&str> = lines.iter().map(|s| s.as_str()).collect();

    let result = solve(&refs);
    writeln!(out, "{}", result).unwrap();
}
]]
	local buf = vim.api.nvim_get_current_buf()
	local line_count = vim.api.nvim_buf_line_count(buf)
	if line_count == 1 and vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] == "" then
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(template, "\n"))
	else
		print("Buffer not empty — template not inserted")
	end
end, { desc = "[CP] Insert solution template" })

---------------------
-- Go
---------------------

-- Buffer-local Go keymaps that only activate in .go files
vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",
	callback = function(ev)
		local buf = ev.buf
		local o = function(desc)
			return { buffer = buf, silent = true, desc = desc }
		end

		keymap.set("n", "<leader>gR", "<cmd>split | terminal go run .<CR>", o("[Go] Run module"))
		keymap.set("n", "<leader>gT", "<cmd>split | terminal go test ./...<CR>", o("[Go] Test all"))
		keymap.set("n", "<leader>gt", "<cmd>split | terminal go test %<CR>", o("[Go] Test file"))
		keymap.set("n", "<leader>gb", "<cmd>split | terminal go build ./...<CR>", o("[Go] Build"))
		keymap.set("n", "<leader>gv", "<cmd>split | terminal go vet ./...<CR>", o("[Go] Vet"))
		keymap.set("n", "<leader>gm", "<cmd>split | terminal go mod tidy<CR>", o("[Go] Mod tidy"))
		keymap.set("n", "<leader>gi", function()
			vim.lsp.inlay_hint.enable(
				not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }),
				{ bufnr = buf }
			)
		end, o("[Go] Toggle inlay hints"))
	end,
})

---------------------
-- Diagnostics
---------------------

keymap.set("n", "<leader>dd", function()
	local current = vim.diagnostic.config().virtual_text
	vim.diagnostic.config({ virtual_text = not current })
end, { desc = "Toggle inline diagnostics" })

keymap.set("n", "<leader>dl", "<cmd>lua vim.diagnostic.setloclist()<CR>", { desc = "Diagnostics to location list" })
