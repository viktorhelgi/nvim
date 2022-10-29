local rust_tools = require("rust-tools")

local km = vim.keymap

local opts = {silent = true, buffer = bufnr}


local my_on_attach = function(client, bufnr)
    vim.o.foldmethod = 'marker'
    
    -- require('aerial').on_attach(client, bufnr)
    km.set( 'n', '<leader>at', '<cmd>AerialToggle!<CR>', opts)
    km.set( 'n', '<leader>a{', '<cmd>AerialPrev<CR>', opts)
    km.set( 'n', '<leader>a}', '<cmd>AerialNext<CR>', opts)
    km.set( 'n', '<leader>a[', '<cmd>AerialPrevUp<CR>', opts)
    km.set( 'n', '<leader>a]', '<cmd>AerialNextUp<CR>', opts)





    vim.cmd("set colorcolumn=101")
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    km.set( 'n', '<leader>[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts )
    km.set( 'n', '<leader>]', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts )

    -- km.set( 'n', 'gi', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts )
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = false

local rust_analyzer_config = {
    capabilities = capabilities,
    on_attach = my_on_attach,
    settings = {
        ["rust-analyzer"] = {
            procMacro = {
                enable = false
            },
            diagnostics = {
                enable = true,
                disabled = {"unresolved-proc-macro"}
            }
        }
    },
    filetypes = { 'rust', 'rs' },
    checkOnSave = {
        enable = true,
    },
    server = {
        -- path = "C:/Users/Lenovo/AppData/Local/nvim-data/lsp_servers/rust/rust-analyzer.exe"
        cmd = 'rust-analyzer'
    },
    handlers = {
        ["textDocument/hover"] = require('vim.lsp').with(
            vim.lsp.handlers.hover, {
            -- Use a sharp border with `FloatBorder` highlights
            border = "single",
            width = 80
        })
    }
}

rust_tools.setup({
  server = rust_analyzer_config
})


-- Commands:
-- RustEnableInlayHints
-- RustDisableInlayHints
-- RustSetInlayHints
-- RustUnsetInlayHints

-- Set inlay hints for the current buffer
rust_tools.inlay_hints.set()
-- Unset inlay hints for the current buffer
rust_tools.inlay_hints.unset()

-- Enable inlay hints auto update and set them for all the buffers
rust_tools.inlay_hints.enable()
-- Disable inlay hints auto update and unset them for all buffers
rust_tools.inlay_hints.disable()

