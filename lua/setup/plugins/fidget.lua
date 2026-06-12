return {
	"j-hui/fidget.nvim",
	event = "LspAttach",
	config = function()
		require("fidget").setup({
			progress = {
				poll_rate = 0,
				suppress_on_insert = false,
				ignore_done_already = false,
				ignore_empty_message = false,
				display = {
					render_limit = 16,
					done_ttl = 3,
					done_icon = "✓",
					progress_icon = { pattern = "dots", period = 1 },
				},
			},
			notification = {
				poll_rate = 10,
				filter = vim.log.levels.INFO,
				override_vim_notify = true,
				window = {
					normal_hl = "Comment",
					winblend = 0,
					border = "none",
					align = "bottom",
					relative = "editor",
				},
			},
		})
	end,
}
