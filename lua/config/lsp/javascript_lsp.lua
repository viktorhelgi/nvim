local null_ls = require("null-ls")
local eslint = require("eslint")


local opts = { noremap = true, silent = false }

local on_attach = function(client, bufnr)
    -- format on save
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>zt', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gk', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

null_ls.setup()

eslint.setup({
    bin = 'eslint', -- or `eslint_d`

    on_attach = on_attach,
    filetypes = { "javascript" },
    code_actions = {
        enable = true,
        apply_on_save = {
            enable = true,
            types = { "problem" }, -- "directive", "problem", "suggestion", "layout"
        },
        disable_rule_comment = {
            enable = true,
            location = "separate_line", -- or `same_line`
        },
    },
    diagnostics = {
        enable = true,
        report_unused_disable_directives = false,
        run_on = "type", -- or `save`
    },
})
