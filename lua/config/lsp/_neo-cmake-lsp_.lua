-- This strips out &nbsp; and some ending escaped backslashes out of hover
-- strings because the pyright LSP is... odd with how it creates hover strings.

-- local hover = function(_, result, ctx, config)
--     if not (result and result.contents) then
--         print("thath1")
--         return pcall(vim.lsp.handlers.hover(_, result, ctx, config), 1)
--     end
--     if type(result.contents) == "string" then
--         print("thth2")
--         local s = string.gsub(result.contents or "", "&nbsp;", " ")
--         print(s)
--         s = string.gsub(s, [[\\\n]], [[\n]])
--         print(s)
--         result.contents = s
--         print("2")
--         return pcall(vim.lsp.handlers.hover(_, result, ctx, config), 2)
--     else
--         print("thth3")
--         local s = string.gsub((result.contents or {}).value or "", "&nbsp;", " ")
--         s = string.gsub(s, "\\\n", "\n")
--         result.contents.value = s
--         print("3")
--         return pcall(vim.lsp.handlers.hover(_, result, ctx, config), 3)
--     end
-- end

-- rest of lsp config goes here
-- this get passed into lspconfig.setup
--  or server:setup_lsp() from nvim-lsp-installer
--  ...

local opts = { noremap = true, silent = false }
local on_attach = function(client, bufnr)

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- vim.api.nvim_buf_set_option(bufnr, 'nowrap', 'true')
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>]', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gef', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'geq', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>zt', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gk', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
end


local configs = require("lspconfig.configs")
local nvim_lsp = require("lspconfig")
if not configs.neocmake then
    configs.neocmake = {
        default_config = {
            cmd = { "neocmakelsp", "--stdio" },
            filetypes = { "cmake" },
            root_dir = function(fname)
                return nvim_lsp.util.find_git_ancestor(fname)
            end,
            single_file_support = true, -- suggested
            on_attach = on_attach,
            -- handlers = {
                -- ["textDocument/hover"] = vim.lsp.with(hover),
            -- }
        }
    }
    nvim_lsp.neocmake.setup({})
end
