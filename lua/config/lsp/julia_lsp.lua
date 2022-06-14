






--
local function map(mode, bind, exec, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend('force', options, opts)
	end
	vim.api.nvim_set_keymap(mode, bind, exec, opts)
end
--
--
-- local opts = { noremap=true, silent=false }
-- local on_attach_julia = function(client, bufnr)
--     vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
--     vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD',       '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
--     -- vim.api.nvim_set_keymap('n', 'gd',       '<cmd>lua vim.lsp.buf.definition()<CR>zt', opts)
--     vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gk',       '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
--     vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gI',       '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--     vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs',       '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--     vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
--     vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr',       '<cmd>lua vim.lsp.buf.references()<CR>', opts)
--     vim.api.nvim_buf_set_keymap(bufnr, 'n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
--     vim.api.nvim_buf_set_keymap(bufnr, 'n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
--     vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gef', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
--     vim.api.nvim_buf_set_keymap(bufnr, 'n', 'geq', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
-- end



local lspconfig = require('lspconfig')



lspconfig.julials.setup({
    settings = {
        julia = {
            analysis = {
                stubPath = 'C:/Users/Lenovo/.julia/packages'
            }
        }
    },
--     on_new_config = function(new_config, _)
--         local julia = vim.fn.expand("C:/Users/Lenovo/AppData/Local/Programs/Julia-1.7.0/bin/julia")
--         if require'lspconfig'.util.path.is_file(julia) then
--             new_config.cmd[1] = julia
--         end
--     end,
--     on_attach = on_attach_julia,
--     filetypes = {'julia'},
--     cmd = { "julia", "--startup-file=no", "--history-file=no", "-e", '    # Load LanguageServer.jl: attempt to load from ~/.julia/environments/nvim-lspconfig\n    # with the regular load path as a fallback\n    ls_install_path = joinpath(\n        get(DEPOT_PATH, 1, joinpath(homedir(), ".julia")),\n        "environments", "nvim-lspconfig"\n    )\n    pushfirst!(LOAD_PATH, ls_install_path)\n    using LanguageServer\n    popfirst!(LOAD_PATH)\n    depot_path = get(ENV, "JULIA_DEPOT_PATH", "")\n    project_path = let\n        dirname(something(\n            ## 1. Finds an explicitly set project (JULIA_PROJECT)\n            Base.load_path_expand((\n                p = get(ENV, "JULIA_PROJECT", nothing);\n                p === nothing ? nothing : isempty(p) ? nothing : p\n            )),\n            ## 2. Look for a Project.toml file in the current working directory,\n            ##    or parent directories, with $HOME as an upper boundary\n            Base.current_project(),\n            ## 3. First entry in the load path\n            get(Base.load_path(), 1, nothing),\n            ## 4. Fallback to default global environment,\n            ##    this is more or less unreachable\n            Base.load_path_expand("@v#.#"),\n        ))\n    end\n    @info "Running language server" VERSION pwd() project_path depot_path\n    server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path)\n    server.runlinter = true\n    run(server)\n  ' }
})


local opt = { silent=true } --empty opt for maps with no extra options



map('n', '<F2>', ':w<CR>:winc l<CR>iinclude("create_available_chamfer.jl")<CR>', opt)













