return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    -- Disable markdownlint here since none-ls handles it
    linters_by_ft = {
      markdown = {},
    },
  },
}
