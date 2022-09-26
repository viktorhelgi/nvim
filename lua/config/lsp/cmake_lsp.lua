
require('lspconfig').cmake.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {debounce_text_changes = 150}
})
