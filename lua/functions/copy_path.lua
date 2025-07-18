local M = {}

-- Copy absolute file path to clipboard
function M.copy_file_path()
  local filepath = vim.fn.expand("%:p")
  if filepath == "" then
    vim.notify("No file in current buffer", vim.log.levels.WARN)
    return
  end
  
  vim.fn.setreg("+", filepath)
  vim.notify("Copied path: " .. filepath, vim.log.levels.INFO)
end

-- Copy absolute file path with line number to clipboard
function M.copy_file_path_with_line()
  local filepath = vim.fn.expand("%:p")
  if filepath == "" then
    vim.notify("No file in current buffer", vim.log.levels.WARN)
    return
  end
  
  local line_number = vim.fn.line(".")
  local path_with_line = filepath .. ":" .. line_number
  
  vim.fn.setreg("+", path_with_line)
  vim.notify("Copied path with line: " .. path_with_line, vim.log.levels.INFO)
end

return M