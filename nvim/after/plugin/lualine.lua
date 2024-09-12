local navic = require("nvim-navic")

local function buffer_path()
    return vim.fn.expand('%')
end

require('lualine').setup {
    options = {
        theme = 'auto'
    },
    sections = {
        lualine_a = { 'mode'},
        lualine_b = { buffer_path },
        lualine_c = {
            {
                function()
                    return navic.get_location()
                end,
                cond = function()
                    return navic.is_available()
                end
            },
        },
        lualine_x = {'branch'}
    },
}
