
local root_dir = require('lspconfig').util.root_pattern({
	"Pipfile",
	"pyproject.toml",
	"setup.py",
	"setup.cfg",
	"venv",
	"requirements.yml",
	"pyrightconfig.json",
    ".letsgo"
})

require('lspconfig').tsserver.setup({
    root_dir = root_dir,
    single_file_support = true,
    filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
    on_attach = function(client, bufnr)

        require('nvim-ts-autotag').setup()

        local opts = {silent=true, bufnr=bufnr}

        vim.cmd('setlocal shiftwidth=2')
        vim.cmd('setlocal colorcolumn=81')

        vim.keymap.set('n', "'L", "<CMD>e ~/.config/nvim/lua/viktor/lsp/tsserver.lua<CR>", opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
        vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

        vim.cmd("set colorcolumn=101")
        vim.keymap.set('i', '<C-space>', '<C-x><C-o>')
        vim.keymap.set('n', '\'/',  '<cmd>e styles/Home.module.css<cr>')
    end
})
