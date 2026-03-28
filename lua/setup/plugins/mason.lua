return {
	"williamboman/mason.nvim",

	lazy = false,

	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},

	config = function()
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				-- Formatters & Linters
				"prettier",
				"stylua",
				"isort",
				"black",
				"pylint",
				"eslint_d",
				"solhint",
				-- Rust specific (remove clippy - it's installed via rustup)
				"rust_analyzer", -- LSP
				"codelldb", -- Debugger
				"rustfmt", -- Formatter
				-- Go
				"gopls",
				-- C/C++
				"clangd",
				"clang-format",
			},
		})
	end,
}
