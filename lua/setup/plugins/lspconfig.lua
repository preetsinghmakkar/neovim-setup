return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },

	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},

	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap

		-- capabilities
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- keymaps
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				keymap.set("n", "K", vim.lsp.buf.hover, opts)
				-- Use trouble.nvim for multi-result LSP navigation.
				-- Native quickfix doesn't auto-focus and can't be closed with q/Esc
				-- from the calling window. Trouble handles focus and q-to-close itself.
				keymap.set("n", "gd", "<cmd>Trouble lsp_definitions toggle<CR>", opts)
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				keymap.set("n", "gi", "<cmd>Trouble lsp_implementations toggle<CR>", opts)
				keymap.set("n", "gr", "<cmd>Trouble lsp_references toggle<CR>", opts)
				keymap.set("n", "gy", "<cmd>Trouble lsp_type_definitions toggle<CR>", opts)
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			end,
		})

		-- Native quickfix/loclist fallback: q and Esc close the window when focused.
		-- Handles the case where something other than the keymaps above opens a qf list.
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "qf",
			callback = function(ev)
				vim.keymap.set("n", "q",   "<cmd>q<CR>", { buffer = ev.buf, silent = true })
				vim.keymap.set("n", "<Esc>", "<cmd>q<CR>", { buffer = ev.buf, silent = true })
			end,
		})

		-- Diagnostics — Neovim 0.10+ API (replaces deprecated vim.fn.sign_define)
		vim.diagnostic.config({
			virtual_text = {
				prefix = "■",   -- matches the ■ bullet in the target screenshot
				source = "if_many",
			},
			float = {
				border = "rounded",
				source = "always",
			},
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		})

		-- setup mason-lspconfig with handlers
		-- NOTE: rust_analyzer is intentionally excluded — rustaceanvim manages it
		mason_lspconfig.setup({
			ensure_installed = {
				"ts_ls",
				"html",
				"cssls",
				"tailwindcss",
				"svelte",
				"lua_ls",
				"graphql",
				"emmet_ls",
				"prismals",
				"pyright",
				"clangd",
				"gopls",
				"solidity_ls_nomicfoundation",
			},
			handlers = {
				-- default handler
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,

				-- Guard: rustaceanvim owns rust-analyzer exclusively.
				-- If Mason installed it previously, this empty handler stops
				-- lspconfig from starting a second rust-analyzer process.
				["rust_analyzer"] = function() end,

				-- lua_ls specific config
				["lua_ls"] = function()
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								diagnostics = { globals = { "vim" } },
								workspace = {
									library = vim.api.nvim_get_runtime_file("", true),
									checkThirdParty = false,
								},
							},
						},
					})
				end,

				-- gopls with inlay hints, gofumpt, and organize-imports on save
				["gopls"] = function()
					lspconfig.gopls.setup({
						capabilities = capabilities,
						settings = {
							gopls = {
								analyses = {
									unusedparams = true,
									shadow = true,
								},
								staticcheck = true,
								gofumpt = true,
								hints = {
									assignVariableTypes = true,
									compositeLiteralFields = true,
									constantValues = true,
									functionTypeParameters = true,
									parameterNames = true,
									rangeVariableTypes = true,
								},
							},
						},
						on_attach = function(client, bufnr)
							if client.server_capabilities.inlayHintProvider then
								vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
							end
							vim.api.nvim_create_autocmd("BufWritePre", {
								buffer = bufnr,
								callback = function()
									vim.lsp.buf.code_action({
										context = { only = { "source.organizeImports" } },
										apply = true,
									})
								end,
							})
						end,
					})
				end,

				-- ts_ls with better settings for large codebases
				["ts_ls"] = function()
					lspconfig.ts_ls.setup({
						capabilities = capabilities,
						settings = {
							typescript = {
								inlayHints = {
									includeInlayParameterNameHints = "all",
									includeInlayFunctionParameterTypeHints = true,
									includeInlayVariableTypeHints = true,
									includeInlayPropertyDeclarationTypeHints = true,
									includeInlayFunctionLikeReturnTypeHints = true,
									includeInlayEnumMemberValueHints = true,
								},
							},
							javascript = {
								inlayHints = {
									includeInlayParameterNameHints = "all",
									includeInlayFunctionParameterTypeHints = true,
									includeInlayVariableTypeHints = true,
								},
							},
						},
					})
				end,
			},
		})
	end,
}
