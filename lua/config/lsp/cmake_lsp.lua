
local opts = { noremap = true, silent = false }

local my_on_attach = function(client, bufnr)

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- vim.api.nvim_buf_set_option(bufnr, 'nowrap', 'true')
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>]', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gef', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'geq', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>zt', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gk', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

require('lspconfig').cmake.setup({
    -- capabilities = capabilities,
    on_attach = my_on_attach,
    -- flags = {debounce_text_changes = 150}
})
