local M = {}

-- Variable to track the state of LSP and format on save
vim.g.lsp_format_enabled = true

-- Function to toggle LSP clients
function M.toggle_lsp()
  local lsp_format_enabled = vim.g.lsp_format_enabled
  
  if lsp_format_enabled then
    -- Disable all active LSP clients
    for _, client in ipairs(vim.lsp.get_active_clients()) do
      vim.lsp.buf_detach_client(0, client.id)
    end
    vim.notify("LSP disabled for current buffer", vim.log.levels.INFO)
  else
    -- Re-attach LSP clients by reloading the buffer
    local current_buf = vim.api.nvim_get_current_buf()
    local current_file = vim.api.nvim_buf_get_name(current_buf)
    vim.cmd("edit " .. current_file)
    vim.notify("LSP enabled for current buffer", vim.log.levels.INFO)
  end
  
  -- Toggle the state
  vim.g.lsp_format_enabled = not lsp_format_enabled
  
  return vim.g.lsp_format_enabled
end

-- Function to toggle format on save
function M.toggle_format_on_save()
  local lsp_format_enabled = vim.g.lsp_format_enabled
  
  if lsp_format_enabled then
    -- Disable format on save
    vim.g.lsp_format_enabled = false
    
    -- Disable LazyVim's format on save
    if LazyVim and LazyVim.format then
      LazyVim.format.disabled = true
    end
    
    vim.notify("Format on save disabled", vim.log.levels.INFO)
  else
    -- Enable format on save
    vim.g.lsp_format_enabled = true
    
    -- Enable LazyVim's format on save
    if LazyVim and LazyVim.format then
      LazyVim.format.disabled = false
    end
    
    vim.notify("Format on save enabled", vim.log.levels.INFO)
  end
  
  return vim.g.lsp_format_enabled
end

-- Function to toggle both LSP and format on save
function M.toggle_lsp_and_format()
  local lsp_format_enabled = vim.g.lsp_format_enabled
  
  if lsp_format_enabled then
    -- Disable both
    vim.g.lsp_format_enabled = false
    
    -- Disable LazyVim's format on save
    if LazyVim and LazyVim.format then
      LazyVim.format.disabled = true
    end
    
    -- Disable all active LSP clients
    for _, client in ipairs(vim.lsp.get_active_clients()) do
      vim.lsp.buf_detach_client(0, client.id)
    end
    vim.notify("LSP and format on save disabled", vim.log.levels.INFO)
  else
    -- Enable both
    vim.g.lsp_format_enabled = true
    
    -- Enable LazyVim's format on save
    if LazyVim and LazyVim.format then
      LazyVim.format.disabled = false
    end
    
    -- Re-attach LSP clients by reloading the buffer
    local current_buf = vim.api.nvim_get_current_buf()
    local current_file = vim.api.nvim_buf_get_name(current_buf)
    vim.cmd("edit " .. current_file)
    vim.notify("LSP and format on save enabled", vim.log.levels.INFO)
  end
  
  return vim.g.lsp_format_enabled
end

return M 