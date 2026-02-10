-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Live grep project (NOTE: This overrides the git group!)
map("n", "<leader>g", function()
  Snacks.picker.grep()
end, { desc = "Live Grep Project" })

-- Live grep current file
map("n", "<leader>gf", function()
  Snacks.picker.grep_buffers()
end, { desc = "Live Grep Current File" })

-- Terminal
map("n", "<leader>t", function()
  Snacks.terminal()
end, { desc = "Terminal" })

-- Split window (horizontal)
-- NOTE: This overrides the search group! Use <leader>/ for search instead
map("n", "<leader>s", "<C-w>s", { desc = "Split Window Horizontal" })

-- Format and save
map("n", "<leader>F", function()
  LazyVim.format({ force = true })
  vim.cmd("write")
end, { desc = "Format and Save" })

-- Home dashboard (dashboard-nvim)
map("n", "<leader>h", "<cmd>Dashboard<cr>", { desc = "Home Dashboard" })

-- Select all
map("n", "<leader>a", "ggVG", { desc = "Select All" })

-- Move Lines Up/Down in Normal Mode
map("n", "<A-Down>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-Up>", ":m .-2<CR>==", { desc = "Move line up" })

-- Move Selection Up/Down in Visual Mode
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
