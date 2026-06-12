return {
	"williamboman/mason.nvim",

	lazy = false,

	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},

	config = function()
		require("mason").setup({
			ui = {
				border = "rounded",
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				-- Formatters
				"prettier",
				"stylua",
				"isort",
				"black",
				"clang-format",
				"rustfmt",

				-- Linters
				"pylint",
				"eslint_d",
				"solhint",      -- Solidity linter
				"shellcheck",   -- Shell script linter

				-- Rust tooling (rust_analyzer managed by rustaceanvim/rustup)
				"codelldb",     -- Debugger for Rust/C/C++

				-- Go
				"gopls",
				"gofumpt",

				-- C/C++
				"clangd",

				-- TypeScript/JS
				"typescript-language-server",

				-- Solidity
				"nomicfoundation-solidity-language-server",
			},
			auto_update = false,
			run_on_start = true,
		})
	end,
}
