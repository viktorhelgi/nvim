
require('lspconfig').tailwindcss.setup({
    -- filetypes = { 'css' },
    on_attach = function(_, _)
        -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        local cmp = require('cmp.init')
        local types = require('cmp.types')
        cmp.setup({
            mapping = cmp.mapping.preset.insert({
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
                -- ['<C-Space>'] = cmp.mapping.complete({}),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<Tab>'] = cmp.mapping.confirm({
                    behavior = types.cmp.ConfirmBehavior.Insert,
                    select = true,
                }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            sources = {
                { name = 'nvim_lsp' },
                { name = 'path' }
            }, {
                { name = 'buffer' }
            }
        })
        vim.keymap.set('i', '<C-o>', '<C-x><C-o>')
    end

})
