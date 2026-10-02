local map = vim.keymap.set

-- arrow keys navigate splits in normal mode; use hjkl for movement
map("n", "<Up>", "<C-w><Up>")
map("n", "<Down>", "<C-w><Down>")
map("n", "<Left>", "<C-w><Left>")
map("n", "<Right>", "<C-w><Right>")

-- move lines up/down, reindenting
map("n", "<C-j>", ":m .+1<CR>==", { silent = true })
map("n", "<C-k>", ":m .-2<CR>==", { silent = true })
map("v", "<C-j>", ":m '>+1<CR>gv=gv", { silent = true })
map("v", "<C-k>", ":m '<-2<CR>gv=gv", { silent = true })

-- reselect visual block after shifting indentation
map("v", "<", "<gv")
map("v", ">", ">gv")

-- clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- diagnostics
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })
