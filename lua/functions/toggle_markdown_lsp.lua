return function()
  vim.g.markdown_lsp_disabled = not vim.g.markdown_lsp_disabled

  if vim.g.markdown_lsp_disabled then
    vim.notify("Markdown LSP disabled", vim.log.levels.INFO, { title = "LSP" })
    -- The autocmds in autocmds.lua will handle detaching the client
    vim.cmd("e!") -- Reload the file to trigger the autocmds
  else
    vim.notify("Markdown LSP enabled", vim.log.levels.INFO, { title = "LSP" })
    -- The autocmds will not prevent the lsp from attaching
    vim.cmd("e!") -- Reload the file to trigger the autocmds
  end
end
