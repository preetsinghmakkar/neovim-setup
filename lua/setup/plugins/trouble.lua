return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
  opts = {
    focus = true,   -- auto-focus the Trouble window when it opens
    keys = {
      q     = "close",   -- q closes from inside Trouble
      ["<Esc>"] = "close",
    },
  },
  cmd = "Trouble",
  keys = {
    { "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>",             desc = "Workspace diagnostics (Trouble)" },
    { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Document diagnostics (Trouble)" },
    { "<leader>xq", "<cmd>Trouble quickfix toggle<CR>",                desc = "Quickfix list (Trouble)" },
    { "<leader>xl", "<cmd>Trouble loclist toggle<CR>",                 desc = "Location list (Trouble)" },
    { "<leader>xt", "<cmd>Trouble todo toggle<CR>",                    desc = "TODOs (Trouble)" },
    -- Close from anywhere — closes Trouble + native qf/loclist
    { "<leader>xc", "<cmd>Trouble close<CR><cmd>cclose<CR><cmd>lclose<CR>", desc = "Close Trouble/quickfix/loclist" },
  },
}
