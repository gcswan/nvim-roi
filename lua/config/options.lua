-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.o.timeout = true
vim.o.timeoutlen = 300
-- Set to false to disable auto format
vim.g.lazyvim_blink_main = false

--- FORMATTING ---
vim.g.lazyvim_eslint_auto_format = true
-- Enable the option to require a Prettier config file
-- If no prettier config file is found, the formatter will not be used
vim.g.lazyvim_prettier_needs_config = false
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
