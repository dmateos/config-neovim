-- Language servers, started with the built-in client (vim.lsp.start).
-- On nvim 0.11+ this could become vim.lsp.config()/vim.lsp.enable().
local servers = {
  gopls = {
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    cmd = { "gopls" },
    root_markers = { "go.work", "go.mod", ".git" },
  },
  pyright = {
    filetypes = { "python" },
    cmd = { "pyright-langserver", "--stdio" },
    root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
    settings = {
      -- let ruff handle imports; pyright just does types
      pyright = { disableOrganizeImports = true },
      python = { analysis = { autoSearchPaths = true, useLibraryCodeForTypes = true } },
    },
  },
  ruff = {
    filetypes = { "python" },
    cmd = { "ruff", "server" },
    root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
  },
  lua_ls = {
    filetypes = { "lua" },
    cmd = { "lua-language-server" },
    root_markers = { ".luarc.json", ".git" },
    settings = { Lua = { diagnostics = { globals = { "vim" } } } },
  },
  bashls = {
    filetypes = { "sh", "bash" },
    cmd = { "bash-language-server", "start" },
    root_markers = { ".git" },
  },
}

-- mason packages to keep installed (binaries land on nvim's PATH)
local mason_packages = {
  "gopls", "pyright", "ruff", "lua-language-server", "bash-language-server", "goimports",
}

return {
  {
    "williamboman/mason.nvim",
    lazy = false, -- puts its bin dir on PATH for the servers and formatters
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
      local registry = require("mason-registry")
      registry.refresh(function()
        for _, name in ipairs(mason_packages) do
          local ok, pkg = pcall(registry.get_package, name)
          if ok and not pkg:is_installed() then pkg:install() end
        end
      end)
    end,
  },

  {
    "saghen/blink.cmp",
    version = "1.*", -- release tags ship a prebuilt fuzzy matcher
    lazy = false, -- capabilities are needed before the first server starts
    opts = {
      keymap = { preset = "super-tab" }, -- <Tab> to accept, like supertab
      completion = { documentation = { auto_show = true } },
      sources = { default = { "lsp", "path", "buffer" } },
    },
    config = function(_, opts)
      require("blink.cmp").setup(opts)
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local group = vim.api.nvim_create_augroup("dman-lsp", { clear = true })

      for name, server in pairs(servers) do
        vim.api.nvim_create_autocmd("FileType", {
          group = group,
          pattern = server.filetypes,
          callback = function(args)
            if vim.fn.executable(server.cmd[1]) == 0 then return end
            local root = vim.fs.root(args.buf, server.root_markers)
            vim.lsp.start({
              name = name,
              cmd = server.cmd,
              root_dir = root or vim.fs.dirname(vim.api.nvim_buf_get_name(args.buf)),
              settings = server.settings,
              capabilities = capabilities,
            })
          end,
        })
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        group = group,
        callback = function(args)
          local map = function(l, r, desc)
            vim.keymap.set("n", l, r, { buffer = args.buf, desc = desc })
          end
          map("gd", vim.lsp.buf.definition, "Go to definition")
          map("gr", "<cmd>Telescope lsp_references<CR>", "References")
          map("gI", vim.lsp.buf.implementation, "Go to implementation")
          map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
          map("<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", "Document symbols")
        end,
      })

      vim.diagnostic.config({ virtual_text = true, severity_sort = true, float = { border = "rounded" } })
    end,
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    keys = {
      { "<leader>F", function() require("conform").format({ lsp_format = "fallback" }) end, desc = "Format buffer" },
    },
    opts = {
      formatters_by_ft = {
        go = { "goimports" },
        python = { "ruff_organize_imports", "ruff_format" },
      },
      -- gofmt-on-save as vim-go did; python is formatted on demand with <leader>F
      format_on_save = function(buf)
        if vim.bo[buf].filetype == "go" then return { timeout_ms = 1000 } end
      end,
    },
  },
}
