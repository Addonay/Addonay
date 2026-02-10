return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local function apply_highlights()
        local c = require("onedarkpro.helpers").get_colors()
        local set = vim.api.nvim_set_hl
        set(0, "DashboardHeader", { fg = c.orange, bold = true })
        set(0, "DashboardFooter", { fg = c.fg_gutter })
        set(0, "DashboardDesc", { fg = c.fg })
        set(0, "DashboardKey", { fg = c.blue })
        set(0, "DashboardIcon", { fg = c.cyan })
        set(0, "DashboardShortcut", { fg = c.green })
        set(0, "DashboardProjectTitle", { fg = c.blue, bold = true })
        set(0, "DashboardProjectIcon", { fg = c.blue })
        set(0, "DashboardMruTitle", { fg = c.blue, bold = true })
        set(0, "DashboardMruIcon", { fg = c.blue })
      end

      apply_highlights()
      vim.api.nvim_create_autocmd("ColorScheme", { callback = apply_highlights })

      local font = {
        A = { " ███ ", "█   █", "█████", "█   █", "█   █" },
        B = { "████ ", "█   █", "████ ", "█   █", "████ " },
        C = { " ████", "█    ", "█    ", "█    ", " ████" },
        D = { "████ ", "█   █", "█   █", "█   █", "████ " },
        E = { "█████", "█    ", "████ ", "█    ", "█████" },
        F = { "█████", "█    ", "████ ", "█    ", "█    " },
        G = { " ████", "█    ", "█  ██", "█   █", " ███ " },
        H = { "█   █", "█   █", "█████", "█   █", "█   █" },
        I = { "█████", "  █  ", "  █  ", "  █  ", "█████" },
        J = { "█████", "   █ ", "   █ ", "█  █ ", " ██  " },
        K = { "█  █ ", "█ █  ", "██   ", "█ █  ", "█  █ " },
        L = { "█    ", "█    ", "█    ", "█    ", "█████" },
        M = { "█   █", "██ ██", "█ █ █", "█   █", "█   █" },
        N = { "█   █", "██  █", "█ █ █", "█  ██", "█   █" },
        O = { " ███ ", "█   █", "█   █", "█   █", " ███ " },
        P = { "████ ", "█   █", "████ ", "█    ", "█    " },
        Q = { " ███ ", "█   █", "█   █", "█  ██", " ████" },
        R = { "████ ", "█   █", "████ ", "█ █  ", "█  ██" },
        S = { " ████", "█    ", " ███ ", "    █", "████ " },
        T = { "█████", "  █  ", "  █  ", "  █  ", "  █  " },
        U = { "█   █", "█   █", "█   █", "█   █", " ███ " },
        V = { "█   █", "█   █", "█   █", " █ █ ", "  █  " },
        W = { "█   █", "█   █", "█ █ █", "██ ██", "█   █" },
        X = { "█   █", " █ █ ", "  █  ", " █ █ ", "█   █" },
        Y = { "█   █", " █ █ ", "  █  ", "  █  ", "  █  " },
        Z = { "█████", "   █ ", "  █  ", " █   ", "█████" },
        ["?"] = { "█████", "   █ ", "  █  ", "     ", "  █  " },
      }

      local function ascii_word(word)
        local lines = { "", "", "", "", "" }
        for i = 1, #word do
          local ch = word:sub(i, i)
          local glyph = font[ch] or font["?"]
          for l = 1, 5 do
            if lines[l] ~= "" then
              lines[l] = lines[l] .. " "
            end
            lines[l] = lines[l] .. glyph[l]
          end
        end
        return lines
      end

      local day = os.date("%A"):upper()
      local header = ascii_word(day)

      local spaced = day:gsub(".", "%0 "):sub(1, -2)
      table.insert(header, spaced)

      table.insert(header, "")
      table.insert(header, os.date("%Y-%m-%d %H:%M:%S") .. "  |  Sharp tools make good work.")
      table.insert(header, "")

      require("dashboard").setup({
        theme = "hyper",
        hide = {
          statusline = false,
          tabline = false,
          winbar = false,
        },
        config = {
          header = header,
          week_header = { enable = false },
          packages = { enable = true },
          shortcut = {
            {
              icon = "󰏗 ",
              desc = "Update",
              group = "DashboardShortcut",
              action = "Lazy update",
              key = "u",
            },
            {
              icon = "󰈞 ",
              desc = "Files",
              group = "DashboardShortcut",
              action = "lua Snacks.picker.files()",
              key = "f",
            },
            {
              icon = "󰗼 ",
              desc = "Apps",
              group = "DashboardShortcut",
              action = "Mason",
              key = "a",
            },
            {
              icon = " ",
              desc = "Dotfiles",
              group = "DashboardShortcut",
              action = "lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })",
              key = "d",
            },
          },
          project = {
            enable = true,
            limit = 8,
            icon = "󰏓 ",
            label = "Recently Projects:",
          },
          mru = {
            enable = true,
            limit = 10,
            icon = "󰈔 ",
            label = "Most Recent Files:",
          },
          footer = { "" },
        },
      })
    end,
  },
}
