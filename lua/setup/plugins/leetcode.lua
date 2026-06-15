return {
	"kawre/leetcode.nvim",
	build = ":TSUpdate html",

	-- MUST be lazy = false so the VimEnter autocmd is set up before that event fires.
	-- If loaded via VeryLazy, `nvim leetcode.nvim` silently does nothing.
	lazy = false,

	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-treesitter/nvim-treesitter",
	},

	opts = {
		-- Launch with: nvim leetcode.nvim
		arg = "leetcode.nvim",

		-- Primary language
		lang = "rust",

		-- Where solutions are stored (`directory` is deprecated — use storage.home)
		storage = {
			home = vim.fn.stdpath("data") .. "/leetcode/",
		},

		-- Use telescope for problem picker
		picker = { provider = "telescope" },

		-- Show daily problem on dashboard
		daily_picker = true,

		-- Logging (helpful when debugging auth issues)
		logging = true,

		-- Description panel
		description = {
			position = "left",
			width = "40%",
			show_stats = true,
		},

		-- Console (test I/O results)
		console = {
			open_on_enter = false,
			size = {
				width = "90%",
				height = "75%",
			},
			dir = "row",
			result = { size = "60%" },
			testcase = {
				virt_text = true,
				size = "40%",
			},
		},

		-- Internal panel keymaps (work inside description/console panels)
		keys = {
			toggle = { "q" },
			confirm = { "<CR>" },
			reset_testcase = "r",
			use_testcase = "U",
			focus_testcase = "H",
			focus_result = "L",
		},

		-- Hooks: set buffer-local keymaps when a problem is opened
		hooks = {
			["question_enter"] = {
				function()
					local bufnr = vim.api.nvim_get_current_buf()
					local o = function(desc)
						return { buffer = bufnr, silent = true, desc = desc }
					end

					vim.keymap.set("n", "<leader>lcr", "<cmd>Leet run<CR>", o("[LC] Run test cases"))
					vim.keymap.set("n", "<leader>lcs", "<cmd>Leet submit<CR>", o("[LC] Submit solution"))
					vim.keymap.set("n", "<leader>lcd", "<cmd>Leet desc<CR>", o("[LC] Toggle description"))
					vim.keymap.set("n", "<leader>lcc", "<cmd>Leet console<CR>", o("[LC] Toggle console"))
					vim.keymap.set("n", "<leader>lci", "<cmd>Leet info<CR>", o("[LC] Problem info/hints"))
					vim.keymap.set("n", "<leader>lcl", "<cmd>Leet lang<CR>", o("[LC] Switch language"))
					vim.keymap.set("n", "<leader>lcy", "<cmd>Leet yank<CR>", o("[LC] Yank solution code"))
					vim.keymap.set("n", "<leader>lcR", "<cmd>Leet reset<CR>", o("[LC] Reset to starter code"))
					vim.keymap.set("n", "<leader>lcb", "<cmd>Leet last_submit<CR>", o("[LC] Load last submission"))
				end,
			},
		},
	},

	config = function(_, opts)
		require("leetcode").setup(opts)

		-- Global keymaps.
		-- NOTE: :Leet subcommands (run, submit, cookie, etc.) only exist after the
		-- full session starts via `nvim leetcode.nvim`. These keymaps are intended
		-- to be used INSIDE that session, not from a regular nvim instance.
		vim.keymap.set("n", "<leader>lc", "<cmd>Leet<CR>", { desc = "[LC] Go to menu" })
		vim.keymap.set("n", "<leader>lcq", "<cmd>Leet list<CR>", { desc = "[LC] Problem list" })
		vim.keymap.set("n", "<leader>lct", "<cmd>Leet tabs<CR>", { desc = "[LC] Problem tabs" })
		vim.keymap.set("n", "<leader>lce", "<cmd>Leet daily<CR>", { desc = "[LC] Daily challenge" })
		vim.keymap.set("n", "<leader>lcm", "<cmd>Leet random<CR>", { desc = "[LC] Random problem" })
		vim.keymap.set("n", "<leader>lco", "<cmd>Leet open<CR>", { desc = "[LC] Open in browser" })
		-- Cookie update — only call this after the session is already running
		vim.keymap.set("n", "<leader>lca", "<cmd>Leet cookie update<CR>", { desc = "[LC] Update cookie (session only)" })
		vim.keymap.set("n", "<leader>lcx", "<cmd>Leet cookie delete<CR>", { desc = "[LC] Sign out (session only)" })
	end,
}
