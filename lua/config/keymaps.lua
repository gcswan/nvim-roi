-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = LazyVim.safe_keymap_set

map("i", "jj", "<ESC>", { desc = "ESC", silent = true })

map("n", "<C-h>", require("nvim-tmux-navigation").NvimTmuxNavigateLeft)
map("n", "<C-j>", require("nvim-tmux-navigation").NvimTmuxNavigateDown)
map("n", "<C-k>", require("nvim-tmux-navigation").NvimTmuxNavigateUp)
map("n", "<C-l>", require("nvim-tmux-navigation").NvimTmuxNavigateRight)
map("n", "<C-\\>", require("nvim-tmux-navigation").NvimTmuxNavigateLastActive)
map("n", "<C-Space>", require("nvim-tmux-navigation").NvimTmuxNavigateNext)
