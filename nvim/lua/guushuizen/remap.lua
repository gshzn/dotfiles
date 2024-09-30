vim.g.mapleader = " "
vim.keymap.set("n", "<leader>x", vim.cmd.x)
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
vim.keymap.set("n", "<leader>cd", ":cd %:p:h")
vim.cmd("command W w")
vim.cmd("command Q q")

