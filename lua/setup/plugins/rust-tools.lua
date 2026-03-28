return {
	-- Enhanced Rust features using native LSP
	{
		"mrcjkb/rustaceanvim",
		version = "^5", -- use v5
		ft = { "rust" },
		config = function()
			vim.g.rustaceanvim = {
				-- Plugin configuration
				tools = {
					hover_actions = {
						replace_hover = true,
					},
					runnables = {
						use_telescope = true,
					},
				},
				-- LSP configuration
				server = {
					on_attach = function(client, bufnr)
						-- Keymaps specific to Rust
						local opts = { buffer = bufnr, silent = true }

						-- Run tests under cursor
						vim.keymap.set("n", "<leader>rt", function()
							vim.cmd("RustLsp runnables")
						end, opts)

						-- Expand macro
						vim.keymap.set("n", "<leader>rm", function()
							vim.cmd("RustLsp expandMacro")
						end, opts)

						-- View parent module
						vim.keymap.set("n", "<leader>rp", function()
							vim.cmd("RustLsp parentModule")
						end, opts)

						-- Open Cargo.toml
						vim.keymap.set("n", "<leader>rc", function()
							vim.cmd("RustLsp openCargoToml")
						end, opts)

						-- Code actions
						vim.keymap.set({ "n", "v" }, "<leader>ca", function()
							vim.cmd("RustLsp codeAction")
						end, opts)
					end,
					default_settings = {
						["rust-analyzer"] = {
							cargo = {
								features = "all",
							},
							checkOnSave = {
								command = "clippy",
								extraArgs = { "--", "-W", "clippy::all" },
							},
							procMacro = {
								enable = true,
							},
						},
					},
				},
			}
		end,
	},

	-- Debugging support for Rust
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Setup dap-ui
			dapui.setup()

			-- Keymaps for debugging
			vim.keymap.set("n", "<F5>", dap.continue, { desc = "Continue debugging" })
			vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step over" })
			vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step into" })
			vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Step out" })
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
			vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
			vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })

			-- Auto open/close dap-ui
			vim.api.nvim_create_autocmd("User", {
				pattern = "DapStopped",
				callback = function()
					dapui.open()
				end,
			})

			-- Setup codelldb for Rust debugging
			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
					args = { "--port", "${port}" },
				},
			}

			dap.configurations.rust = {
				{
					name = "Launch",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
				{
					name = "Launch release",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/release/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}
		end,
	},

	-- Test runner for Rust
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"rouge8/neotest-rust",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-rust")({
						args = { "--no-capture" },
					}),
				},
			})

			-- Keymaps for testing
			vim.keymap.set("n", "<leader>tt", function()
				require("neotest").run.run()
			end, { desc = "Run nearest test" })
			vim.keymap.set("n", "<leader>tf", function()
				require("neotest").run.run(vim.fn.expand("%"))
			end, { desc = "Run all tests in file" })
			vim.keymap.set("n", "<leader>ts", function()
				require("neotest").summary.toggle()
			end, { desc = "Toggle test summary" })
		end,
	},
}
