return {
	"saecki/crates.nvim",
	event = { "BufRead Cargo.toml" },
	config = function()
		local crates = require("crates")

		crates.setup({
			lsp = {
				enabled = true,
				actions = true,
				completion = true,
				hover = true,
			},
			completion = {
				cmp = { enabled = true },
			},
			null_ls = { enabled = false },
		})

		-- Only load keymaps when in Cargo.toml
		vim.api.nvim_create_autocmd("BufRead", {
			group = vim.api.nvim_create_augroup("CratesNvimKeymaps", { clear = true }),
			pattern = "Cargo.toml",
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				vim.keymap.set("n", "<leader>ct", crates.toggle, vim.tbl_extend("force", opts, { desc = "[Crates] Toggle crate info" }))
				vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, vim.tbl_extend("force", opts, { desc = "[Crates] Show versions" }))
				vim.keymap.set("n", "<leader>cf", crates.show_features_popup, vim.tbl_extend("force", opts, { desc = "[Crates] Show features" }))
				vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, vim.tbl_extend("force", opts, { desc = "[Crates] Show dependencies" }))
				vim.keymap.set("n", "<leader>cu", crates.update_crate, vim.tbl_extend("force", opts, { desc = "[Crates] Update crate" }))
				vim.keymap.set("n", "<leader>cU", crates.update_all_crates, vim.tbl_extend("force", opts, { desc = "[Crates] Update all crates" }))
				vim.keymap.set("n", "<leader>cx", crates.expand_plain_crate_to_inline_table, vim.tbl_extend("force", opts, { desc = "[Crates] Expand to inline table" }))
				vim.keymap.set("n", "<leader>cX", crates.extract_crate_into_table, vim.tbl_extend("force", opts, { desc = "[Crates] Extract to table" }))
				vim.keymap.set("n", "<leader>co", crates.open_crates_io, vim.tbl_extend("force", opts, { desc = "[Crates] Open crates.io" }))
				vim.keymap.set("n", "<leader>ch", crates.open_homepage, vim.tbl_extend("force", opts, { desc = "[Crates] Open homepage" }))
				vim.keymap.set("n", "<leader>cr", crates.open_repository, vim.tbl_extend("force", opts, { desc = "[Crates] Open repository" }))
			end,
		})
	end,
}
