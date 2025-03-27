-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Auto-format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.tsx", "*.ts", "*.jsx", "*.js" },
  callback = function()
    -- Only run EslintFixAll if formatting is enabled
    if not LazyVim.format.disabled then
      vim.cmd("silent! EslintFixAll")
    end
  end,
  group = vim.api.nvim_create_augroup("MyAutocmdsJavaScriptFormatting", { clear = true }),
})

-- Handle Markdown LSP state
local markdown_group = vim.api.nvim_create_augroup("MarkdownLspControl", { clear = true })

-- Check global LSP state when opening Markdown files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function(event)
    -- If LSP is globally disabled for markdown, mark this buffer
    if vim.g.markdown_lsp_disabled then
      vim.b[event.buf].markdown_lsp_disabled = true
      
      -- Clear diagnostics for this buffer
      vim.diagnostic.reset(nil, event.buf)
      
      -- Detach any existing marksman client
      local clients = vim.lsp.get_active_clients({ bufnr = event.buf })
      for _, client in ipairs(clients) do
        if client.name == "marksman" then
          vim.lsp.buf_detach_client(event.buf, client.id)
          break
        end
      end
    end
  end,
  group = markdown_group,
})

-- Prevent LSP from attaching to markdown files if disabled
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.name == "marksman" then
      local bufnr = event.buf
      -- Check both global and buffer-local state
      if vim.g.markdown_lsp_disabled or vim.b[bufnr].markdown_lsp_disabled then
        vim.lsp.buf_detach_client(bufnr, client.id)
        vim.diagnostic.reset(nil, bufnr)
      end
    end
  end,
  group = markdown_group,
})

-- Use a safer approach to clear diagnostics for markdown files
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  pattern = { "*.md", "*.markdown" },
  callback = function(event)
    local bufnr = event.buf
    if vim.bo[bufnr].filetype == "markdown" and (vim.g.markdown_lsp_disabled or vim.b[bufnr].markdown_lsp_disabled) then
      vim.diagnostic.reset(nil, bufnr)
      
      -- Check if any marksman client got attached and detach it
      local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
      for _, client in ipairs(clients) do
        if client.name == "marksman" then
          vim.lsp.buf_detach_client(bufnr, client.id)
          break
        end
      end
    end
  end,
  group = markdown_group,
})

-- Auto-format Markdown files on save when enabled
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.md", "*.markdown" },
  callback = function()
    local markdown_format = require("functions.markdown_format")
    -- Only format if both the local format toggle and LazyVim formatter are enabled
    if markdown_format.auto_format_enabled and not LazyVim.format.disabled then
      markdown_format.format_markdown()
    end
  end,
  group = markdown_group,
})
