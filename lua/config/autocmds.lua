local group = vim.api.nvim_create_augroup("dman", { clear = true })

-- briefly highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function() vim.highlight.on_yank() end,
})

-- return to last cursor position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
  group = group,
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(args.buf) then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- python and go use 4-space/tab conventions
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "python",
  callback = function() vim.opt_local.tabstop = 4 end,
})
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "go",
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "ruby",
  command = [[inoreabbrev <buffer> pry! require "pry"; binding.pry]],
})
