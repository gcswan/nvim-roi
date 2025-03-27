return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      ["markdown-toc"] = {
        condition = function(_, ctx)
          -- Skip if formatting is disabled
          if LazyVim.format.disabled then
            return false
          end
          
          for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
            if line:find("<!%-%- toc %-%->") then
              return true
            end
          end
        end,
      },
      ["markdownlint-cli2"] = {
        condition = function(_, ctx)
          -- Skip if formatting is disabled
          if LazyVim.format.disabled then
            return false
          end
          
          local diag = vim.tbl_filter(function(d)
            return d.source == "markdownlint"
          end, vim.diagnostic.get(ctx.buf))
          return #diag > 0
        end,
      },
      sqlfluff = {
        args = { "fix", "--dialect", "postgres" }, -- or your preferred SQL dialect
      },
    },
    formatters_by_ft = {
      sql = { "sqlfluff" },
      ["markdown"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
      ["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
    },
  },
}
