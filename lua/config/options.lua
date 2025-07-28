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

vim.opt.directory = "/tmp"

-- Specify the path to Node.js v22 LTS for Neovim
vim.g.node_host_prog = "/Users/gswan/.nvm/versions/node/v22.5.0/bin/node"

-- Configure for LSP processes
vim.g.lsp_utils_node_binary = "/Users/gswan/.nvm/versions/node/v22.5.0/bin/node"

-- Set environment variables for all spawned processes
vim.env.PATH = "/Users/gswan/.nvm/versions/node/v22.5.0/bin:" .. vim.env.PATH

-- Ensure Mason uses this Node.js version
vim.g.mason_node_executable = "/Users/gswan/.nvm/versions/node/v22.5.0/bin/node"

-- automatically reload the buffer from disk on focus
vim.opt.autoread = true
