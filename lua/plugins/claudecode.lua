return {
  {
    "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for git operations
    },
    cond = function()
      return vim.fn.executable("claude") == 1
    end,
    config = function()
      require("claude-code").setup({
        -- Terminal window settings
        window = {
          split_ratio = 0.3,
          position = "float", -- "botright", "topleft", "vertical", "float"
          enter_insert = true,
          hide_numbers = true,
          hide_signcolumn = true,

          -- Floating window configuration
          float = {
            width = "85%",
            height = "85%",
            row = "center",
            col = "center",
            relative = "editor",
            border = "rounded",
          },
        },

        -- File refresh settings
        refresh = {
          enable = true,
          updatetime = 100,
          timer_interval = 1000,
          show_notifications = true,
        },

        -- Command variants
        command_variants = {
          claude = "claude",
          continue = "claude --continue",
          resume = "claude --resume",
        },
      })
    end,
    keymaps = {
      toggle = {
        normal = "<C-g>", -- Normal mode keymap for toggling Claude Code, false to disable
        terminal = "<C-g>", -- Terminal mode keymap for toggling Claude Code, false to disable
        variants = {
          continue = "<leader>cC", -- Normal mode keymap for Claude Code with continue flag
          verbose = "<leader>cV", -- Normal mode keymap for Claude Code with verbose flag
        },
      },
      window_navigation = true, -- Enable window navigation keymaps (<C-h/j/k/l>)
      scrolling = true, -- Enable scrolling keymaps (<C-f/b>) for page up/down
    },
  },
}
