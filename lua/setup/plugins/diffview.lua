return {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
	config = function()
		require("diffview").setup({
			enhanced_diff_hl = true,
			view = {
				default = { layout = "diff2_horizontal" },
				merge_tool = { layout = "diff3_horizontal", disable_diagnostics = true },
			},
			hooks = {
				diff_buf_read = function(bufnr)
					-- Disable diagnostics in diff buffers (less noise)
					vim.diagnostic.disable(bufnr)
				end,
			},
		})

		-- Open diff view (compare working tree against HEAD)
		vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "[Git] Open diff view" })

		-- File history for current file
		vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", { desc = "[Git] File history" })

		-- Full repo/branch history
		vim.keymap.set("n", "<leader>gH", "<cmd>DiffviewFileHistory<CR>", { desc = "[Git] Repo history" })

		-- Close diffview
		vim.keymap.set("n", "<leader>gc", "<cmd>DiffviewClose<CR>", { desc = "[Git] Close diff view" })

		-- Compare against a specific commit/branch (prompt)
		vim.keymap.set("n", "<leader>gD", function()
			local ref = vim.fn.input("Diff against (branch/commit): ")
			if ref ~= "" then
				vim.cmd("DiffviewOpen " .. ref)
			end
		end, { desc = "[Git] Diff against ref" })
	end,
}
