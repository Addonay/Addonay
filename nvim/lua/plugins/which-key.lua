-- Which-key configuration to update keymap groups
return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        {
          mode = { "n", "x" },
          -- Override <leader>g to be live grep instead of git
          { "<leader>g", desc = "Live Grep", icon = " " },
          { "<leader>gf", desc = "Grep Current File", icon = " " },
          -- Override <leader>s to be split instead of search
          { "<leader>s", desc = "Split Horizontal", icon = " " },
          -- New keymaps
          { "<leader>t", desc = "Terminal", icon = " " },
          { "<leader>F", desc = "Format & Save", icon = " " },
          { "<leader>h", desc = "Home Dashboard", icon = " " },
          { "<leader>a", desc = "Select All", icon = "󰒆 " },
        },
      },
    },
  },
}