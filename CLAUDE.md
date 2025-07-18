# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture

This is a LazyVim-based Neovim configuration that follows the LazyVim plugin architecture:

- **init.lua**: Entry point that bootstraps the configuration by requiring `config.lazy`
- **lua/config/**: Core configuration files
  - `lazy.lua`: Sets up the Lazy.nvim plugin manager and imports plugin specs
  - `options.lua`: Neovim options and Node.js path configuration
  - `keymaps.lua`: Custom keybindings and tmux navigation
  - `autocmds.lua`: Auto-commands
- **lua/plugins/**: Plugin configurations as separate modules
- **lua/functions/**: Custom utility functions

## Key Features

- **LazyVim Base**: Built on LazyVim framework with ESLint and Prettier integrations
- **Node.js Setup**: Configured to use Node.js v22.5.0 from ~/.nvm/versions/node/v22.5.0/bin/node
- **Multiple Colorschemes**: Extensive collection including tokyonight (default), gruvbox, rose-pine, catppuccin, and others
- **Tmux Integration**: Seamless navigation between Neovim and tmux panes
- **Custom Functions**: Utility functions for case switching, LSP toggling, and markdown formatting

## Commands

### Code Formatting
- **Linter**: StyLua is configured for Lua formatting (stylua.toml)
- **Format on Save**: Controlled by LazyVim's format system and custom toggle functions
- **ESLint**: Enabled with auto-format (vim.g.lazyvim_eslint_auto_format = true)
- **Prettier**: Enabled without requiring config file (vim.g.lazyvim_prettier_needs_config = false)

### Custom Key Bindings
- `jj` - Escape from insert mode
- `<C-h/j/k/l>` - Tmux navigation
- `<Leader>ck` - Switch between camelCase and snake_case
- `<Leader>tm` - Toggle Markdown LSP
- `<Leader>tf` - Toggle Markdown auto-format
- `<Leader>tl` - Toggle LSP
- `<Leader>tp` - Toggle format on save
- `<Leader>ta` - Toggle both LSP and format on save

## Plugin Management

Uses Lazy.nvim plugin manager with:
- LazyVim as the base configuration
- Custom plugins in lua/plugins/ directory
- Plugin updates checked automatically (checker.enabled = true)
- Lazy loading disabled by default (lazy = false)

## Development Environment

- **Terminal Colors**: Full terminal color support enabled
- **Transparency**: Many colorschemes configured with transparency options
- **Performance**: Optimized with disabled default plugins and performance tweaks
- **Node.js Integration**: Configured for LSP processes and Mason tool installer

## Custom Functions

- **switch_case.lua**: Converts between camelCase and snake_case
- **toggle_lsp_format.lua**: Provides granular control over LSP and formatting
- **toggle_markdown_lsp.lua**: Markdown-specific LSP toggling
- **markdown_format.lua**: Markdown formatting controls