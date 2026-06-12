return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	config = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		require("nvim-tree").setup({
			view = {
				width = 35,
				side = "left",
			},
			renderer = {
				indent_markers = {
					enable = true,
				},
			},
			git = {
				enable = true,
				ignore = false,
			},
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
		})

		-- Global keymaps to toggle NvimTree
		vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
		vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFile<CR>", { desc = "Find file in explorer" })
	end,
}
