return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		harpoon:setup({
			settings = {
				save_on_toggle = true,
				sync_on_ui_close = true,
			},
		})

		-- Add current file to harpoon list
		vim.keymap.set("n", "<leader>ha", function()
			harpoon:list():add()
			vim.notify("Harpoon: file added", vim.log.levels.INFO)
		end, { desc = "[Harpoon] Add file" })

		-- Toggle harpoon quick-menu (shows your marked files)
		vim.keymap.set("n", "<leader>hh", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "[Harpoon] Menu" })

		-- Jump to harpoon slots 1-4 (instant — no keystrokes wasted)
		vim.keymap.set("n", "<leader>1", function()
			harpoon:list():select(1)
		end, { desc = "[Harpoon] File 1" })
		vim.keymap.set("n", "<leader>2", function()
			harpoon:list():select(2)
		end, { desc = "[Harpoon] File 2" })
		vim.keymap.set("n", "<leader>3", function()
			harpoon:list():select(3)
		end, { desc = "[Harpoon] File 3" })
		vim.keymap.set("n", "<leader>4", function()
			harpoon:list():select(4)
		end, { desc = "[Harpoon] File 4" })

		-- Cycle through harpoon list
		vim.keymap.set("n", "<leader>hn", function()
			harpoon:list():next()
		end, { desc = "[Harpoon] Next file" })
		vim.keymap.set("n", "<leader>hp", function()
			harpoon:list():prev()
		end, { desc = "[Harpoon] Prev file" })
	end,
}
