local navic = require('nvim-navic')
local navbuddy = require('nvim-navbuddy')
--
-- lsp_attach is where you enable features that only work
-- if there is a language server active in the file
local lsp_attach = function(client, bufnr)
    local opts = {buffer = bufnr}

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

    vim.keymap.set('n', 'gf', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)

    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end

    navbuddy.attach(client, bufnr)
end

require'lspconfig'.phpactor.setup{
    on_attach = lsp_attach,
    handlers = {
        ['textDocument/publishDiagnostics'] = function() end
    },
}

require'lspconfig'.pyright.setup{
    on_attach = lsp_attach,
    settings = {
        python = {
            pythonPath = vim.env.VIRTUAL_ENV and vim.env.VIRTUAL_ENV .. "/bin/python" or "/usr/local/bin/python3",
        }
    }
}

-- require'lspconfig'.pylsp.setup {
--     on_attach = lsp_attach,
--     settings = {
--         pylsp = {
--             plugins = {
--                 rope_autoimport = {
--                     enabled = true
--                 }
--             }
--         }
--     }
-- }

require'lspconfig'.lua_ls.setup{
    on_attach = lsp_attach,
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
}

local cmp = require("cmp")

local select_first_item_mapping = cmp.mapping(function(fallback)
    if cmp.visible() then
        local entry = cmp.get_selected_entry()
        if not entry then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        end
        cmp.confirm()
    else
        fallback()
    end
end, {"i","s","c",})

cmp.setup({
    sources = {
        {name = 'nvim_lsp'},
    },
    snippet = {
        expand = function(args)
            -- You need Neovim v0.10 to use vim.snippet
            vim.snippet.expand(args.body)
        end,
    },

    mapping = cmp.mapping.preset.insert({
        ["<Enter>"] = select_first_item_mapping,
        ["<Tab>"] = select_first_item_mapping,
    })
})

