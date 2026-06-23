return {
	"crnvl96/claudecode.nvim",
	dependencies = { "akinsho/toggleterm.nvim" },
	event = "VeryLazy",
	opts = {
		terminal = {
			provider = "toggleterm",
			split_side = "right",
			split_width_percentage = 0.38,
		},
	},
	keys = {
		{ "<leader>ac", "<cmd>ClaudeCode<CR>", desc = "[AI] Toggle Claude Code" },
		{
			"<leader>as",
			"<cmd>ClaudeCodeSend<CR>",
			mode = "v",
			desc = "[AI] Send selection to Claude",
		},
		{ "<leader>af", "<cmd>ClaudeCodeFocus<CR>", desc = "[AI] Focus Claude window" },
	},
	config = function(_, opts)
		require("claudecode").setup(opts)

		-- Register <leader>a group in which-key
		local ok, wk = pcall(require, "which-key")
		if ok then
			wk.add({ "<leader>a", group = "AI (Claude)" })
		end
	end,
}
