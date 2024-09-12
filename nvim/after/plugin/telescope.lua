local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-t>', builtin.git_files, {})
vim.keymap.set('n', '<C-b>', builtin.buffers, {})

vim.keymap.set('n', '<leader>pws', function()
	local word = vim.fn.expand("<cword>")
	builtin.grep_string({ search = word })
end)

