return {
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    opts = {
      options = {
        cursorline = true,
        transparency = false,
        highlight_inactive_windows = true,
        terminal_colors = true,
      },
      styles = {
        comments = "italic",
        keywords = "italic",
      },
      highlights = {
        CursorLineNr = { fg = "${orange}", bold = true },
        LineNr = { fg = "${line_number}" },
        Pmenu = { bg = "${float_bg}" },
        PmenuSel = { bg = "${selection}", fg = "${fg}" },
        PmenuThumb = { bg = "${blue}" },
        NormalFloat = { bg = "${float_bg}" },
        FloatBorder = { fg = "${fg_gutter}", bg = "${float_bg}" },
        WinSeparator = { fg = "${fg_gutter}" },
        TelescopeBorder = { fg = "${fg_gutter}", bg = "${float_bg}" },
        TelescopeTitle = { fg = "${blue}", bold = true },
        TelescopePromptTitle = { fg = "${green}", bold = true },
        TelescopeResultsTitle = { fg = "${purple}", bold = true },
        TelescopePreviewTitle = { fg = "${orange}", bold = true },
        SnacksIndent = { fg = "${indentline}" },
        SnacksIndentScope = { fg = "${blue}" },
        SnacksDashboardNormal = { bg = "${bg}" },
        SnacksDashboardBorder = { fg = "${fg_gutter}", bg = "${bg}" },
      },
    },
  },

  -- Keep Catppuccin installed for icon palette usage.

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark_dark",
    },
  },
}
