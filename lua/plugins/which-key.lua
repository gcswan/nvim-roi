return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    -- Extend the existing which-key configuration
    opts.spec = opts.spec or {}
    
    -- Add our toggle group to the spec
    table.insert(opts.spec, {
      { "<leader>t", name = "+toggle" },
      { "<leader>tm", "<cmd>lua require('functions.toggle_markdown_lsp').toggle_markdown_lsp()<CR>", desc = "Toggle Markdown LSP" },
      { "<leader>tf", "<cmd>lua require('functions.markdown_format').toggle_auto_format()<CR>", desc = "Toggle Markdown Auto-Format" },
    })
    
    return opts
  end,
} 