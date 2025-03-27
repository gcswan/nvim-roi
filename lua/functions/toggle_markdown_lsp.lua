-- Function to toggle LSP for Markdown files
local M = {}

-- Variable to track the state of Markdown LSP
M.markdown_lsp_enabled = true

-- Store original diagnostic settings to restore them later
local original_diagnostic_config = nil

-- Function to toggle LSP for Markdown files
function M.toggle_markdown_lsp()
  -- Toggle the state
  M.markdown_lsp_enabled = not M.markdown_lsp_enabled
  
  -- Set a global variable to track the state
  vim.g.markdown_lsp_disabled = not M.markdown_lsp_enabled
  
  -- Get all markdown buffers
  local buffers = vim.api.nvim_list_bufs()
  local markdown_buffers = {}
  
  for _, bufnr in ipairs(buffers) do
    if vim.api.nvim_buf_is_valid(bufnr) then
      local ft = vim.bo[bufnr].filetype
      if ft == "markdown" then
        table.insert(markdown_buffers, bufnr)
      end
    end
  end
  
  if M.markdown_lsp_enabled then
    -- Enable LSP for Markdown files
    vim.notify("Markdown LSP enabled", vim.log.levels.INFO)
    
    -- Restore original diagnostic settings if we saved them
    if original_diagnostic_config then
      vim.diagnostic.config(original_diagnostic_config)
      original_diagnostic_config = nil
    end
    
    -- Start the LSP for all markdown buffers
    vim.cmd("LspStart marksman")
    
    -- Clear the disabled flag on all markdown buffers
    for _, bufnr in ipairs(markdown_buffers) do
      vim.b[bufnr].markdown_lsp_disabled = nil
    end
  else
    -- Disable LSP for Markdown files
    vim.notify("Markdown LSP disabled", vim.log.levels.INFO)
    
    -- Save current diagnostic settings
    if not original_diagnostic_config then
      original_diagnostic_config = vim.diagnostic.config()
    end
    
    -- Disable diagnostics for markdown files
    vim.diagnostic.config({
      virtual_text = false,
      signs = false,
      underline = false,
      update_in_insert = false,
      severity_sort = false,
    }, vim.api.nvim_create_namespace("marksman"))
    
    -- Clear all diagnostics for markdown buffers
    for _, bufnr in ipairs(markdown_buffers) do
      vim.diagnostic.reset(nil, bufnr)
    end
    
    -- Detach the LSP from all markdown buffers
    for _, bufnr in ipairs(markdown_buffers) do
      local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
      for _, client in ipairs(clients) do
        if client.name == "marksman" then
          vim.lsp.buf_detach_client(bufnr, client.id)
          vim.b[bufnr].markdown_lsp_disabled = true
        end
      end
    end
    
    -- Stop the LSP server
    vim.cmd("LspStop marksman")
  end
end

return M 