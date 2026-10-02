return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        contrast = "hard",
        -- black background, as with the old jellybeans override
        overrides = { Normal = { bg = "#000000" }, SignColumn = { bg = "#000000" } },
      })
      vim.cmd.colorscheme("gruvbox")
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = { theme = "gruvbox", section_separators = "", component_separators = "|" },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    tag = "v2.1.0", -- later versions need nvim 0.11+
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      on_attach = function(buf)
        local gs = require("gitsigns")
        local map = function(l, r, desc) vim.keymap.set("n", l, r, { buffer = buf, desc = desc }) end
        map("]h", function() gs.nav_hunk("next") end, "Next hunk")
        map("[h", function() gs.nav_hunk("prev") end, "Prev hunk")
        map("<leader>hp", gs.preview_hunk, "Preview hunk")
        map("<leader>hr", gs.reset_hunk, "Reset hunk")
        map("<leader>hb", gs.blame_line, "Blame line")
      end,
    },
  },

  -- pops up available keybindings after pressing <leader> etc.
  { "folke/which-key.nvim", event = "VeryLazy", opts = {} },
}
