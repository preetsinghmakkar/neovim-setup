return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function()
		local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
		if not status_ok then
			return
		end

		treesitter.setup({
			ensure_installed = {
				-- Rust & systems
				"rust",
				"toml",
				"c",
				"cpp",
				-- Web / JS / TS
				"javascript",
				"typescript",
				"tsx",
				"html",
				"css",
				"json",
				"json5",
				"graphql",
				-- Solidity
				"solidity",
				-- DevOps / Config
				"yaml",
				"dockerfile",
				"bash",
				"regex",
				-- Neovim / Lua
				"lua",
				"vim",
				"vimdoc",
				"query",
				-- General
				"markdown",
				"markdown_inline",
				"python",
				"git_diff",
				"git_rebase",
				"gitcommit",
				"gitignore",
			},
			auto_install = true,

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},

			indent = { enable = true },

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					node_incremental = "<CR>",
					node_decremental = "<BS>",
					scope_incremental = "<S-CR>",
				},
			},

			-- Textobjects: select functions, classes, params (great for studying codebases)
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = { query = "@function.outer", desc = "Outer function" },
						["if"] = { query = "@function.inner", desc = "Inner function" },
						["ac"] = { query = "@class.outer", desc = "Outer class" },
						["ic"] = { query = "@class.inner", desc = "Inner class" },
						["aa"] = { query = "@parameter.outer", desc = "Outer parameter" },
						["ia"] = { query = "@parameter.inner", desc = "Inner parameter" },
						["ab"] = { query = "@block.outer", desc = "Outer block" },
						["ib"] = { query = "@block.inner", desc = "Inner block" },
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]m"] = { query = "@function.outer", desc = "Next function start" },
						["]]"] = { query = "@class.outer", desc = "Next class start" },
					},
					goto_next_end = {
						["]M"] = { query = "@function.outer", desc = "Next function end" },
						["]["] = { query = "@class.outer", desc = "Next class end" },
					},
					goto_previous_start = {
						["[m"] = { query = "@function.outer", desc = "Prev function start" },
						["[["] = { query = "@class.outer", desc = "Prev class start" },
					},
					goto_previous_end = {
						["[M"] = { query = "@function.outer", desc = "Prev function end" },
						["[]"] = { query = "@class.outer", desc = "Prev class end" },
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>na"] = { query = "@parameter.inner", desc = "Swap next parameter" },
					},
					swap_previous = {
						["<leader>nA"] = { query = "@parameter.inner", desc = "Swap prev parameter" },
					},
				},
			},
		})
	end,
}
