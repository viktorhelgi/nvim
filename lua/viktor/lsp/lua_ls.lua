

local on_attach = function(_, bufnr)
    local opts = {silent = true, buffer = bufnr}

    -- require('lsp_signature').on_attach(require('viktor.config.plugin.lsp_signature'), bufnr) -- no need to specify bufnr if you don't use toggle_key

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.wo.foldmethod = 'indent' -- set fold method to marker

    vim.keymap.set('n', '<leader>rn', function() require('lua_funcs').test_file() end, opts)

    -- "Goto FileType Config"
	vim.keymap.set("n", "'L", "<CMD>e ~/.config/nvim/lua/viktor/lsp/lua_ls.lua<CR>", opts)
end



require('lspconfig').lua_ls.setup {
    on_attach = on_attach,
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- version = 'lua5.4',
                -- path = runtime_path
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                -- library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
                -- library = library,
                ignoreDir = "tests"
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}
