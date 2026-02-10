-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

opt.termguicolors = true
opt.cursorline = true
opt.cursorlineopt = "number"
opt.signcolumn = "yes"
opt.number = true
opt.relativenumber = false
opt.laststatus = 3
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.splitkeep = "screen"
opt.pumblend = 10
opt.showmode = false
opt.fillchars = { eob = " " }
opt.list = true
opt.listchars = { tab = "» ", trail = "·", extends = "›", precedes = "‹", nbsp = "␣" }
