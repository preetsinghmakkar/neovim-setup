-- Project-wide search and replace (essential when studying/refactoring large codebases)
return {
	"MagicDuck/grug-far.nvim",
	cmd = "GrugFar",
	keys = {
		{
			"<leader>sr",
			function()
				require("grug-far").open()
			end,
			desc = "[Search] Project search & replace",
		},
		{
			"<leader>sw",
			function()
				require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
			end,
			desc = "[Search] Search word under cursor",
		},
		{
			"<leader>sf",
			function()
				require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
			end,
			desc = "[Search] Search in current file",
		},
	},
	config = function()
		require("grug-far").setup({
			engine = "ripgrep",
			headerMaxWidth = 80,
			resultsSeparatorLineChar = "─",
			spinnerStates = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
		})
	end,
}
