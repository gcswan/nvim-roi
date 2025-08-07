return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    -- Set bigfile options with much higher thresholds
    opts.bigfile = opts.bigfile or {}
    opts.bigfile.enabled = true
    opts.bigfile.notify = true
    opts.bigfile.size = 10 * 1024 * 1024 -- 10MB file size threshold
    opts.bigfile.line_length = 50000 -- much higher line length threshold
    
    return opts
  end,
}