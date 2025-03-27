-- Functions for formatting Markdown files
local M = {}

-- Toggle auto-formatting on save
M.auto_format_enabled = false

function M.toggle_auto_format()
  M.auto_format_enabled = not M.auto_format_enabled
  
  if M.auto_format_enabled then
    vim.notify("Markdown auto-format on save enabled", vim.log.levels.INFO)
  else
    vim.notify("Markdown auto-format on save disabled", vim.log.levels.INFO)
  end
end

return M 