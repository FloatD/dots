local set = vim.keymap.set

-- telescope
set("n", "<leader>fp", ":Telescope git_files<cr>")
set("n", "<leader>fz", ":Telescope live_grep<cr>")
set("n", "<leader>fo", ":Telescope oldfiles<cr>")

-- tree
set("n", "<leader>e", ":NvimTreeFindFileToggle<cr>")

-- format code using LSP
set("n", "<leader>fmd", vim.lsp.buf.format)

-- nvim-comment
set({"n", "v"}, "<leader>/", ":CommentToggle<cr>")

-- Press <Tab> to expand or jump in a snippet. These can also be mapped separately
-- via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
vim.api.nvim_set_keymap("i", "<Tab>", "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'", { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", "<cmd>lua require'luasnip'.jump(-1)<CR>", { silent = true })

vim.api.nvim_set_keymap("s", "<Tab>", "<cmd>lua require('luasnip').jump(1)<CR>", { silent = true })
vim.api.nvim_set_keymap("s", "<S-Tab>", "<cmd>lua require('luasnip').jump(-1)<CR>", { silent = true })

-- For changing choices in choiceNodes (not strictly necessary for a basic setup).
vim.api.nvim_set_keymap("i", "<C-E>", "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'", { silent = true, expr = true })
vim.api.nvim_set_keymap("s", "<C-E>", "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'", { silent = true, expr = true })

-- local ls = require("luasnip")
--
-- set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
-- set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
-- set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})
--
-- set({"i", "s"}, "<C-E>", function()
--   if ls.choice_active() then
--     ls.change_choice(1)
--   end
-- end, {silent = true})
