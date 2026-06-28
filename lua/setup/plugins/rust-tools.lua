return {
	-- rustaceanvim: the definitive Rust plugin (replaces rust-tools.nvim)
	{
		"mrcjkb/rustaceanvim",
		version = "^5",
		ft = { "rust" },
		config = function()
			vim.g.rustaceanvim = {
				tools = {
					hover_actions = { replace_hover = true },
					runnables = { use_telescope = true },
					-- Show inlay hints (type annotations, param names)
					inlay_hints = {
						auto = true,
						show_parameter_hints = true,
						parameter_hints_prefix = "<- ",
						other_hints_prefix = "=> ",
					},
				},
				server = {
					on_attach = function(client, bufnr)
						local opts = { buffer = bufnr, silent = true }

						-- Rust runnables (tests, binaries, examples) via Telescope
						vim.keymap.set("n", "<leader>rt", function()
							vim.cmd("RustLsp runnables")
						end, vim.tbl_extend("force", opts, { desc = "[Rust] Show runnables" }))

						-- Run the last runnable again (great for iterative CP)
						vim.keymap.set("n", "<leader>rR", function()
							vim.cmd("RustLsp runnables last")
						end, vim.tbl_extend("force", opts, { desc = "[Rust] Re-run last runnable" }))

						-- Expand macro under cursor
						vim.keymap.set("n", "<leader>rm", function()
							vim.cmd("RustLsp expandMacro")
						end, vim.tbl_extend("force", opts, { desc = "[Rust] Expand macro" }))

						-- Navigate to parent module
						vim.keymap.set("n", "<leader>rp", function()
							vim.cmd("RustLsp parentModule")
						end, vim.tbl_extend("force", opts, { desc = "[Rust] Go to parent module" }))

						-- Open Cargo.toml for current crate
						vim.keymap.set("n", "<leader>rc", function()
							vim.cmd("RustLsp openCargoToml")
						end, vim.tbl_extend("force", opts, { desc = "[Rust] Open Cargo.toml" }))

						-- Enhanced code actions (better than generic LSP)
						vim.keymap.set({ "n", "v" }, "<leader>ca", function()
							vim.cmd("RustLsp codeAction")
						end, vim.tbl_extend("force", opts, { desc = "Code actions" }))

						-- Explain error under cursor (Rust compiler errors are rich)
						vim.keymap.set("n", "<leader>re", function()
							vim.cmd("RustLsp explainError")
						end, vim.tbl_extend("force", opts, { desc = "[Rust] Explain error" }))

						-- Open external docs for symbol under cursor
						vim.keymap.set("n", "<leader>ro", function()
							vim.cmd("RustLsp openDocs")
						end, vim.tbl_extend("force", opts, { desc = "[Rust] Open docs.rs" }))

						-- Toggle inlay hints (type/param annotations)
						vim.keymap.set("n", "<leader>ri", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
						end, vim.tbl_extend("force", opts, { desc = "[Rust] Toggle inlay hints" }))

						-- Hover docs (enhanced for Rust)
						vim.keymap.set("n", "K", function()
							vim.cmd("RustLsp hover actions")
						end, vim.tbl_extend("force", opts, { desc = "Hover / actions" }))

						-- Move item up/down (swap struct fields, enum variants, etc.)
						vim.keymap.set("n", "<leader>ru", function()
							vim.cmd("RustLsp moveItem up")
						end, vim.tbl_extend("force", opts, { desc = "[Rust] Move item up" }))
						vim.keymap.set("n", "<leader>rd", function()
							vim.cmd("RustLsp moveItem down")
						end, vim.tbl_extend("force", opts, { desc = "[Rust] Move item down" }))

						-- Enable inlay hints by default in Rust files
						if client.server_capabilities.inlayHintProvider then
							vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
						end
					end,

					default_settings = {
						["rust-analyzer"] = {
							cargo = {
								features = "all",
								buildScripts = { enable = true },
							},
							checkOnSave = {
								command = "clippy",
								extraArgs = { "--", "-W", "clippy::all", "-W", "clippy::pedantic" },
							},
							procMacro = {
								enable = true,
								ignored = {
									["async-trait"] = { "async_trait" },
									["napi-derive"] = { "napi" },
									["async-recursion"] = { "async_recursion" },
								},
							},
							-- Better completion in large codebases
							completion = {
								callable = { snippets = "fill_arguments" },
								fullFunctionSignatures = { enable = true },
							},
							-- Useful when studying large codebases
							hover = {
								actions = {
									references = { enable = true },
									run = { enable = true },
								},
								links = { enable = true },
							},
							imports = {
								granularity = { group = "module" },
								prefix = "self",
							},
							inlayHints = {
								bindingModeHints = { enable = true },
								chainingHints = { enable = true },
								closingBraceHints = { enable = true, minLines = 10 },
								closureReturnTypeHints = { enable = "always" },
								lifetimeElisionHints = { enable = "skip_trivial" },
								maxLength = 25,
								parameterHints = { enable = true },
								reborrowHints = { enable = "always" },
								renderColons = true,
								typeHints = { enable = true, hideClosureInitialization = false },
							},
						},
					},
				},
			}
		end,
	},

	-- Debugging (Rust + C/C++ via codelldb)
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Virtual text (show variable values inline while debugging)
			require("nvim-dap-virtual-text").setup({
				commented = true,
			})

			dapui.setup({
				icons = { expanded = "▾", collapsed = "▸" },
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.4 },
							{ id = "breakpoints", size = 0.2 },
							{ id = "stacks", size = 0.2 },
							{ id = "watches", size = 0.2 },
						},
						size = 40,
						position = "left",
					},
					{
						elements = { { id = "repl", size = 0.5 }, { id = "console", size = 0.5 } },
						size = 10,
						position = "bottom",
					},
				},
			})

			-- Debugger keymaps
			vim.keymap.set("n", "<F5>", dap.continue, { desc = "[Debug] Continue" })
			vim.keymap.set("n", "<F10>", dap.step_over, { desc = "[Debug] Step over" })
			vim.keymap.set("n", "<F11>", dap.step_into, { desc = "[Debug] Step into" })
			vim.keymap.set("n", "<F12>", dap.step_out, { desc = "[Debug] Step out" })
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "[Debug] Toggle breakpoint" })
			vim.keymap.set("n", "<leader>dB", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "[Debug] Conditional breakpoint" })
			vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "[Debug] Open REPL" })
			vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "[Debug] Toggle UI" })
			vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "[Debug] Terminate" })

			-- Auto-open/close DAP UI
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end

			-- codelldb adapter (installed by mason)
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
					name = "Launch (debug)",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
				{
					name = "Launch (release)",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/target/release/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
				{
					name = "Attach to process",
					type = "codelldb",
					request = "attach",
					pid = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
			}

			-- C/C++ configs — separate from Rust; default to build/ dir (cmake) or cwd
			dap.configurations.cpp = {
				{
					name = "Launch (build/)",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/build/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
				{
					name = "Launch (cwd)",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
				{
					name = "Attach to process",
					type = "codelldb",
					request = "attach",
					pid = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
			}
			dap.configurations.c = dap.configurations.cpp
		end,
	},

	-- Test runner
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
						dap_adapter = "codelldb",
					}),
				},
				output = { open_on_run = true },
				summary = { animated = true },
			})

			vim.keymap.set("n", "<leader>tt", function()
				require("neotest").run.run()
			end, { desc = "[Test] Run nearest test" })

			vim.keymap.set("n", "<leader>tf", function()
				require("neotest").run.run(vim.fn.expand("%"))
			end, { desc = "[Test] Run all tests in file" })

			vim.keymap.set("n", "<leader>ts", function()
				require("neotest").summary.toggle()
			end, { desc = "[Test] Toggle test summary" })

			vim.keymap.set("n", "<leader>to", function()
				require("neotest").output.open({ enter = true })
			end, { desc = "[Test] Open test output" })

			vim.keymap.set("n", "<leader>tD", function()
				require("neotest").run.run({ strategy = "dap" })
			end, { desc = "[Test] Debug nearest test" })

			vim.keymap.set("n", "]T", function()
				require("neotest").jump.next({ status = "failed" })
			end, { desc = "Next failed test" })

			vim.keymap.set("n", "[T", function()
				require("neotest").jump.prev({ status = "failed" })
			end, { desc = "Prev failed test" })
		end,
	},
}
