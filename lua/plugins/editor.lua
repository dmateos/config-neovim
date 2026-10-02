return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    cmd = "Telescope",
    keys = {
      { "<leader>ga", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Grep (needs ripgrep)" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help" },
      { "<leader>fd", "<cmd>Telescope diagnostics<CR>", desc = "Diagnostics" },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = { file_ignore_patterns = { "%.pyc$", "__pycache__/" } },
      })
      pcall(telescope.load_extension, "fzf")
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
    keys = {
      { "<leader>n", "<cmd>NvimTreeToggle<CR>", desc = "File tree" },
      { "<leader>N", "<cmd>NvimTreeFindFile<CR>", desc = "Reveal file in tree" },
    },
    opts = {
      filters = { custom = { "\\.pyc$", "__pycache__" } },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master", -- "main" requires nvim 0.11+
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = {
        "bash", "go", "gomod", "python", "ruby", "lua", "vim", "vimdoc",
        "json", "yaml", "toml", "markdown", "markdown_inline", "dockerfile",
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
  },

  { "tpope/vim-fugitive", cmd = { "Git", "G", "Gdiffsplit", "Gread", "Gwrite", "GBrowse" } },
  { "kylechui/nvim-surround", event = "VeryLazy", opts = {} },
  { "jamessan/vim-gnupg" },
}
