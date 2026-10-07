local opt = vim.opt

-- display
opt.termguicolors = true
opt.number = true
opt.cursorline = true
opt.signcolumn = "yes" -- stop gitsigns/diagnostics shifting the text
opt.foldenable = false
opt.shortmess:append("IF") -- I = no intro message, F = no file info on open
opt.listchars = { tab = ">-", trail = "-" }
opt.scrolloff = 3
opt.splitright = true
opt.splitbelow = true

-- behaviour
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.undofile = true -- persistent undo across sessions
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "split" -- live preview of :s, with off-screen matches in a split
opt.updatetime = 250
opt.completeopt = { "menu", "menuone", "noselect" }

-- indent with two spaces by default
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 0
opt.shiftwidth = 0 -- when zero, tabstop is used
opt.smartindent = true

-- assume shell scripts are bash; fixes $(subcommand) highlighting
vim.g.is_bash = 1
