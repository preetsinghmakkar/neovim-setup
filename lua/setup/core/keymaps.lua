-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- use kj to exit insert mode
keymap.set("i", "kj", "<ESC>", { desc = "Exit insert mode with kj" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- Rust Competitive Programming Keymaps

-- Create input file
keymap.set("n", "<leader>ic", function()
	local file = vim.fn.expand("%:r")
	local input_file = file .. ".in"

	-- Check if file exists
	if vim.fn.filereadable(input_file) == 0 then
		local f = io.open(input_file, "w")
		f:write("-- Add your test input here --\n")
		f:close()
		print("Created: " .. input_file)
	else
		print("File already exists: " .. input_file)
	end

	-- Open in split
	vim.cmd("vsplit " .. input_file)
end, { desc = "Create input file" })

-- Run with input file
keymap.set("n", "<leader>ir", function()
	local file = vim.fn.expand("%:r")
	local input_file = file .. ".in"

	if vim.fn.filereadable(input_file) == 1 then
		vim.cmd("split term://cargo run --release < " .. input_file)
	else
		print("No input file found. Use <leader>ic to create one.")
	end
end, { desc = "Run with input file" })

-- Run normally (without input file)
keymap.set("n", "<leader>rr", function()
	vim.cmd("w")
	local ft = vim.bo.filetype

	if ft == "rust" then
		vim.cmd("split term://cargo run --release")
	elseif ft == "cpp" then
		local file = vim.fn.expand("%:r")
		vim.cmd("split term://clang++ % -O2 -std=c++17 -o " .. file .. " && ./" .. file)
	else
		print("No runner for " .. ft)
	end
end, { desc = "Run current file" })

-- Run tests
keymap.set("n", "<leader>rt", function()
	vim.cmd("w")
	if vim.bo.filetype == "rust" then
		vim.cmd("split term://cargo test")
	else
		print("Tests only available for Rust")
	end
end, { desc = "Run tests" })

-- Build with optimizations for CP
keymap.set("n", "<leader>rb", function()
	vim.cmd("w")
	if vim.bo.filetype == "rust" then
		vim.cmd("split term://cargo build --release")
	end
end, { desc = "Build release" })

-- Toggle inline diagnostics
keymap.set("n", "<leader>dd", function()
	vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
end, { desc = "Toggle diagnostics" })
