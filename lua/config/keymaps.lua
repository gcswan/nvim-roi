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
map(
  "n",
  "<Leader>tm",
  '<cmd>lua require("functions.toggle_markdown_lsp").toggle_markdown_lsp()<CR>',
  { desc = "Toggle Markdown LSP", noremap = true, silent = true }
)

-- Toggle auto-format for Markdown files on save
map(
  "n",
  "<Leader>tf",
  '<cmd>lua require("functions.markdown_format").toggle_auto_format()<CR>',
  { desc = "Toggle Markdown Auto-Format", noremap = true, silent = true }
)

-- Toggle LSP and Format on Save
map("n", "<leader>tl", function() require("functions.toggle_lsp_format").toggle_lsp() end, { desc = "Toggle LSP" })
map("n", "<leader>tp", function() require("functions.toggle_lsp_format").toggle_format_on_save() end, { desc = "Toggle Format on Save" })
map("n", "<leader>ta", function() require("functions.toggle_lsp_format").toggle_lsp_and_format() end, { desc = "Toggle LSP and Format on Save" })
