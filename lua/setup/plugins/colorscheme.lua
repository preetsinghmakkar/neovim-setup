return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    require("gruvbox").setup({
      contrast = "hard",
      transparent_mode = true,  -- terminal bg shows through → guaranteed pure black
      terminal_colors = true,
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true,
      dim_inactive = false,
      overrides = {
        -- With transparent_mode, Normal bg = terminal bg (pure black).
        -- Anchor a few surfaces that gruvbox leaves unset in transparent mode.
        WinSeparator = { fg = "#504945", bg = "NONE" },
        NormalFloat  = { bg = "NONE" },
        FloatBorder  = { fg = "#665c54", bg = "NONE" },
        -- CursorLine keeps a subtle highlight so the current line is visible
        CursorLine   = { bg = "#282828" },
        CursorLineNr = { fg = "#fabd2f", bg = "#282828", bold = true },
      },
    })
    vim.o.background = "dark"
    vim.cmd("colorscheme gruvbox")
  end,
}
