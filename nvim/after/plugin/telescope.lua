local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-t>', function()
    local is_git_dir = os.execute('git rev-parse --is-inside-worktree')

    print(is_git_dir)

    if (is_git_dir == 0) then
        builtin.git_files()
    else
        builtin.find_files()
    end
end, {})
vim.keymap.set('n', '<C-b>', builtin.buffers, {})
vim.keymap.set('n', '<C-f>', builtin.live_grep, {})

vim.keymap.set('n', '<leader>pws', function()
	local word = vim.fn.expand("<cword>")
	builtin.grep_string({ search = word })
end)

