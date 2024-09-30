local dap = require("dap")
local dapui = require("dapui")
local dap_python = require("dap-python")

dapui.setup()
require("nvim-dap-virtual-text").setup()

local keymap_opts = {noremap=true}

vim.keymap.set("n", "<leader>dt", function () dapui.toggle() end, keymap_opts)
vim.keymap.set("n", "<leader>ds", function () dap.continue({new=true}) end, keymap_opts)
vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end, keymap_opts)
vim.keymap.set("n", "<leader>do", function() dap.step_over() end, keymap_opts)
vim.keymap.set("n", "<leader>di", function() dap.step_into() end, keymap_opts)
vim.keymap.set("n", "<leader>de", function() dap.terminate() end, keymap_opts)
vim.keymap.set("n", "<leader>dl", function() dap.run_to_cursor() end, keymap_opts)
vim.keymap.set("n", "<leader>dr", function() dapui.close() dapui.open({reset = true}) end, keymap_opts)

vim.keymap.set("n", "<leader>dm", function () dap_python.test_method() end, keymap_opts)
vim.keymap.set("n", "<leader>dc", function () dap_python.test_class() end, keymap_opts)

local set_python_dap = function()
    require('dap-python').setup() -- earlier, so I can setup the various defaults ready to be replaced
    require('dap-python').resolve_python = function()
        return venv_python_path()
    end
    dap.configurations.python = {
        {
            type = 'python';
            request = 'launch';
            name = "Launch file";
            program = "${file}";
            pythonPath = venv_python_path()
        },
    }

    dap.adapters.python = {
        type = 'executable',
        command = venv_python_path(),
        args = {'-m', 'debugpy.adapter'}
    }
end

set_python_dap()
vim.api.nvim_create_autocmd({"DirChanged", "BufEnter"}, {
    callback = function() set_python_dap() end,
})

-- Show breakpoints in line nrs
vim.fn.sign_define('DapBreakpoint', {
    text = '⬤',
    texthl = 'ErrorMsg',
    linehl = '',
    numhl = 'ErrorMsg'
})

vim.fn.sign_define('DapBreakpointCondition', {
    text = '⬤',
    texthl = 'ErrorMsg',
    linehl = '',
    numhl = 'SpellBad'
})
