return {
  "neovim/nvim-lspconfig",
  opts = {
    -- Configure marksman to be manually controlled
    servers = {
      marksman = {
        -- This will be controlled by our toggle function
        autostart = false,
        -- Disable inlay hints for markdown
        settings = {
          inlayHints = {
            enable = false,
          },
        },
      },
    },
    -- Disable inlay hints for markdown files
    inlay_hints = {
      enabled = function(client, bufnr, _)
        if client.name == "marksman" then
          return false
        end
        return true
      end,
    },
    -- Add a custom setup handler for marksman
    setup = {
      marksman = function(_, opts)
        -- Check if LSP should be disabled before setup
        if vim.g.markdown_lsp_disabled then
          return true -- Skip default setup
        end
        return false -- Allow default setup
      end,
    },
  },
} 