return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "default",
    },
    sources = {
      default = { "dadbod" },
      providers = {
        dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
      },
    },
    enabled = function()
      local node = vim.treesitter.get_node()
      local disabled = false
      disabled = disabled or (vim.tbl_contains({ "markdown" }, vim.bo.filetype))
      disabled = disabled or (vim.bo.buftype == "prompt")
      disabled = disabled or (node and string.find(node:type(), "comment"))
      return not disabled
    end,
  },
  dependencies = {
    "kristijanhusak/vim-dadbod-completion",
  },
}
