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

-- swtitches camel case to snake case
map(
  "n",
  "<Leader>ck",
  '<cmd>lua require("./functions/switch_case").switch_case()<CR>',
  { desc = "switch case", noremap = true, silent = true }
)

-- Toggle LSP for Markdown files
map("n", "<leader>lt", function()
  require("functions.toggle_markdown_lsp")()
end, { desc = "Toggle Markdown LSP" })

-- Copy file path keymaps
map("n", "<leader>cw", function()
  require("functions.copy_path").copy_file_path()
end, { desc = "Copy file path" })
map("n", "<leader>cp", function()
  require("functions.copy_path").copy_file_path_with_line()
end, { desc = "Copy file path with line" })

-- Toggle Claude Code
map("n", "<C-g>", "<cmd>ClaudeCode<CR>", { desc = "Toggle Claude Code", noremap = true, silent = true })
map("t", "<C-g>", "<cmd>ClaudeCode<CR>", { desc = "Toggle Claude Code", noremap = true, silent = true })

-- Arial
map("n", "<leader>at", "<cmd>AerialToggle!<CR>", { desc = "Toggle Aerial" })
map("n", "<leader>ao", "<cmd>AerialOpen<CR>", { desc = "Open Aerial" })
map("n", "<leader>ac", "<cmd>AerialClose<CR>", { desc = "Close Aerial" })
map("n", "<leader>af", "<cmd>AerialNavToggle<CR>", { desc = "Aerial Float Nav" })

map("n", "<leader>an", "<cmd>AerialNext<CR>", { desc = "Aerial Next Symbol" })
map("n", "<leader>ap", "<cmd>AerialPrev<CR>", { desc = "Aerial Prev Symbol" })
map("n", "<leader>aun", "<cmd>AerialNextUp<CR>", { desc = "Aerial Next Up Level" })
map("n", "<leader>aup", "<cmd>AerialPrevUp<CR>", { desc = "Aerial Prev Up Level" })

-- gitsigns hunk navigation
map("n", "<leader>gh]", "<cmd>lua require('gitsigns').next_hunk()<CR>", { desc = "Next git hunk" })
map("n", "<leader>gh[", "<cmd>lua require('gitsigns').prev_hunk()<CR>", { desc = "Previous git hunk" })

-- save
map("n", "<leader>w", "<cmd>write<CR>", { desc = "Write buffer" })
map("n", "<leader>wa", "<cmd>wa<CR>", { desc = "Write all buffers" })
map("n", "<leader>wq", "<cmd>wq<CR>", { desc = "Write quit" })
