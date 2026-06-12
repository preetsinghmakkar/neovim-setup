return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		labels = "asdfghjklqwertyuiopzxcvbnm",
		search = { multi_window = true },
		jump = { autojump = false },
		highlight = { backdrop = true },
		modes = {
			char = {
				-- Use flash for f/F/t/T motions too (shows labels for repeated jumps)
				enabled = true,
				jump_labels = true,
			},
		},
	},
	keys = {
		-- <leader>j → jump to any visible position (type 2 chars, pick label)
		{
			"<leader>j",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash jump",
		},
		-- <leader>J → jump using treesitter node selection (great for selecting code blocks)
		{
			"<leader>J",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash treesitter select",
		},
		-- r → remote flash in operator-pending (operate on distant text without moving)
		{
			"r",
			mode = "o",
			function()
				require("flash").remote()
			end,
			desc = "Flash remote",
		},
		-- R → treesitter search in operator/visual
		{
			"R",
			mode = { "o", "x" },
			function()
				require("flash").treesitter_search()
			end,
			desc = "Flash treesitter search",
		},
		-- <C-s> in telescope to toggle flash within telescope results
		{
			"<C-f>",
			mode = { "c" },
			function()
				require("flash").toggle()
			end,
			desc = "Toggle flash search",
		},
	},
}
