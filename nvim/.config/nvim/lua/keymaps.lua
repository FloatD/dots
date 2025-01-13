-- space bar leader key
vim.g.mapleader = " "

-- buffers
vim.keymap.set("n", "<leader>n", ":bn<cr>")
vim.keymap.set("n", "<leader>p", ":bp<cr>")
vim.keymap.set("n", "<leader>x", ":bd<cr>")

-- yank to clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])

-- black python formatting
vim.keymap.set("n", "<leader>fmp", ":silent !black %<cr>")

vim.keymap.set("n", "<leader>rl", function()
  local output = vim.fn.system("love .")
  if vim.v.shell_error ~= 0 then
    vim.notify("Error running love: " .. output, vim.log.levels.ERROR)
  end
end)
