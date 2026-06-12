return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return math.floor(vim.o.columns * 0.4)
				end
			end,
			open_mapping = [[<C-\>]],
			hide_numbers = true,
			shade_terminals = true,
			start_in_insert = true,
			persist_size = true,
			direction = "horizontal",
			close_on_exit = true,
			shell = vim.o.shell,
			float_opts = {
				border = "curved",
				winblend = 3,
			},
		})

		-- Navigate out of terminal back to nvim windows
		-- (consistent with your kj escape)
		vim.keymap.set("t", "kj", "<C-\\><C-n>", { desc = "Exit terminal mode" })
		vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Terminal: move left" })
		vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Terminal: move down" })
		vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Terminal: move up" })
		vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Terminal: move right" })

		-- Floating terminal (great for quick commands)
		-- NOTE: <leader>T* = Terminal namespace (testing uses <leader>t*)
		vim.keymap.set("n", "<leader>TF", function()
			local Terminal = require("toggleterm.terminal").Terminal
			local float = Terminal:new({ direction = "float", hidden = true })
			float:toggle()
		end, { desc = "Terminal: float" })

		-- Vertical terminal (nice for CP: code left, output right)
		vim.keymap.set("n", "<leader>TV", function()
			local Terminal = require("toggleterm.terminal").Terminal
			local vert = Terminal:new({ direction = "vertical", hidden = true })
			vert:toggle()
		end, { desc = "Terminal: vertical" })

		-- Send current line / selection to the open terminal
		vim.keymap.set("n", "<leader>TL", function()
			require("toggleterm").send_current_line()
		end, { desc = "Terminal: send line" })
		vim.keymap.set("v", "<leader>TL", function()
			require("toggleterm").send_lines_to_terminal("visual_lines", false, { args = vim.v.count })
		end, { desc = "Terminal: send selection" })
	end,
}
