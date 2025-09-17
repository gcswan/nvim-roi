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

-- Gitsigns keymaps
map("n", "]h", function()
  if vim.wo.diff then
    vim.cmd.normal({ "]c", bang = true })
  else
    require("gitsigns").nav_hunk("next")
  end
end, { desc = "Next Hunk" })

map("n", "[h", function()
  if vim.wo.diff then
    vim.cmd.normal({ "[c", bang = true })
  else
    require("gitsigns").nav_hunk("prev")
  end
end, { desc = "Prev Hunk" })

map("n", "]H", function()
  require("gitsigns").nav_hunk("last")
end, { desc = "Last Hunk" })

map("n", "[H", function()
  require("gitsigns").nav_hunk("first")
end, { desc = "First Hunk" })

-- Hunk actions
map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", { desc = "Stage Hunk" })
map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", { desc = "Reset Hunk" })
map("n", "<leader>ghS", function()
  require("gitsigns").stage_buffer()
end, { desc = "Stage Buffer" })
map("n", "<leader>ghu", function()
  require("gitsigns").undo_stage_hunk()
end, { desc = "Undo Stage Hunk" })
map("n", "<leader>ghR", function()
  require("gitsigns").reset_buffer()
end, { desc = "Reset Buffer" })

-- Preview and blame
map("n", "<leader>ghp", function()
  require("gitsigns").preview_hunk_inline()
end, { desc = "Preview Hunk Inline" })
map("n", "<leader>ghP", function()
  require("gitsigns").preview_hunk()
end, { desc = "Preview Hunk" })
map("n", "<leader>ghb", function()
  require("gitsigns").blame_line({ full = true })
end, { desc = "Blame Line" })
map("n", "<leader>ghB", function()
  require("gitsigns").blame()
end, { desc = "Blame Buffer" })

-- Diff
map("n", "<leader>ghd", function()
  require("gitsigns").diffthis()
end, { desc = "Diff This" })
map("n", "<leader>ghD", function()
  require("gitsigns").diffthis("~")
end, { desc = "Diff This ~" })

-- Text object
map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "GitSigns Select Hunk" })

-- save
map("n", "<leader>w", "<cmd>write<CR>", { desc = "Write buffer" })
map("n", "<leader>wa", "<cmd>wa<CR>", { desc = "Write all buffers" })
map("n", "<leader>wq", "<cmd>wq<CR>", { desc = "Write quit" })

map("n", "<leader>r", ":source $MYVIMRC<CR>", { desc = "Reload config" })
