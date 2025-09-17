return {
  {
    "3rd/image.nvim",
    build = false,
    opts = {
      backend = "kitty",
      processor = "magick_cli",
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          show_remote_images = true,
        },
      },
    },
  },
  {
    "HakonHarnes/img-clip.nvim",
    opts = {},
    keys = {
      { "<leader>pp", "<cmd>PasteImage<cr>", desc = "Paste image from clipboard" },
    },
  },
}
