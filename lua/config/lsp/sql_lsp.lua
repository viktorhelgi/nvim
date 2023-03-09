-- vim.g.LanguageClient_serverCommands = {
--     sql = {
--         'sql-language-server', 'up', '--method', 'stdio'},
-- }

local lspconfig = require('lspconfig')

-- lspconfig.sqlls.setup {
--     root_dir = lspconfig.util.root_pattern({
--       'README.md',
--       '.git'
--     }),
--     settings = {
--         sqlLanguageServer = {
--             connections = {
--                 name = "bq",
--                 adapter = "biquery",
--                 host = "localhost",
--                 port = 443,
--                 database = "mk2-prod",
--                 projectPaths = {
--                     "/home/viktor/hm/research/fog-analysis"
--                 }
--             }
--         }
--     }
-- }

require 'lspconfig'.sqls.setup {


    root_dir = lspconfig.util.root_pattern({
        'README.md',
        '.git'
    }),
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    -- capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    -- cmd = {"sql-language-server","up", "--method", "stdio" },
    cmd = { "/home/viktor/.local/share/nvim/mason/bin/sqls" },
    on_attach = function(client, bufnr)
        ---Register your source to nvim-cmp.
        local source = require('config.lsp.sql.cmp_source')
        require('cmp').register_source('month', source)

        local cmp = require('cmp')


        local opts2 = { noremap = true, silent = false, buffer = bufnr }
        vim.keymap.set('i', '<C-n>', function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, opts2)
        vim.keymap.set('i', '<C-a>', cmp.mapping.complete({ config = { sources = { { name = 'month'  } } }}), opts2)

        vim.keymap.set('n', '<leader>rl', function()
            local filename = vim.fn.expand('%:p:t:r')
            -- local filename = vim.fn.expand('%:p:t:r')
            local query_command = "bigquery query "..filename.." -d sbRDOuWobz16XG953Vms"
            require('harpoon.tmux').sendCommand("{last}", query_command.."\n")
        end, opts2)

        cmp.setup.filetype('sql', {
            mapping = {
                ['<C-u>'] = cmp.mapping.scroll_docs( -4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<C-p>'] = function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end,
                ['<C-o>'] = cmp.mapping.complete({ config = { sources = cmp.config.sources( { { name = 'nvim_lsp' } }) } }),
                ['<C-l>'] = cmp.mapping.complete({ config = { sources = cmp.config.sources( { { name = 'omni' } }) } }),
                ['<C-b>'] = cmp.mapping.complete({ config = { sources = cmp.config.sources( {}, { { name = 'buffer' } }) } }),

                -- ['<C-n>'] = cmp.mapping.complete({ config = { sources = { { name = 'omni' } } } }),
                ['<C-f>'] = cmp.mapping.complete({ config = { sources = { { name = 'path' } } } })
            },
            sources = {
                { name = 'nvim_lsp' },
                { name = 'path' },
                { name = 'omni' }
            },
            {
                { name = 'buffer' }
            },
            formatting = {
                format = function(entry, vim_item)
                    -- fancy icons and a name of kind
                    -- entry.get_word
                    vim_item.kind = require("lspkind.init").presets.default[vim_item.kind] .. " " .. vim_item.kind
                    -- set a name for each source
                    vim_item.menu = ({
                            buffer = "「Buffer」",
                            nvim_lsp = "「Lsp」",
                            luasnip = "「luasnip」",
                        })[entry.source.name]

                    vim_item.menu = entry:get_completion_item().detail
                    return vim_item
                end,
            }
        })



        require('sqls').on_attach(client, bufnr)
        local opts = { noremap = true, silent = false }

        -- vim.g.omni_sql_default_compl_type = 'syntax'
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lf', '<cmd>Format<CR>', opts)

        vim.api.nvim_buf_set_keymap(bufnr, 'i', "<C-C>a", "<cmd>call sqlcomplete#Map('syntax')<CR><C-X><C-O>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'i', "<C-C>k", "<cmd>call sqlcomplete#Map('sqlKeyword')<CR><C-X><C-O>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'i', "<C-C>f", "<cmd>call sqlcomplete#Map('sqlFunction')<CR><C-X><C-O>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'i', "<C-C>o", "<cmd>call sqlcomplete#Map('sqlOption')<CR><C-X><C-O>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'i', "<C-C>T", "<cmd>call sqlcomplete#Map('sqlType')<CR><C-X><C-O>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'i', "<C-C>s", "<cmd>call sqlcomplete#Map('sqlStatement')<CR><C-X><C-O>", opts)

        local send_r_term = '<cmd>lua require("harpoon.term").sendCommand(1, "\\r")<CR>'
        local send_r_tmux = '<cmd>lua require("harpoon.tmux").sendCommand("!", "\\r")<CR>'

        local command =
        '"cat "..vim.fn.expand("%").." | bq query --use_legacy_sql=false --project_id=mk2-prod --max_rows=100000 --allow_large_results=true --job_timeout_ms=1000"'


        --location=eu \
        --project_id=mk2-prod \
        --use_legacy_sql=false \
        --format=csv \
        --allow_large_results=true \
        --max_rows=1000000000 \
        vim.api.nvim_buf_set_keymap(0, 'n', '<leader>rn',
            '<cmd>lua require("harpoon.term").sendCommand(1, ' .. command .. ')<CR>' .. send_r_term, opts)
        -- vim.api.nvim_buf_set_keymap(0, 'n', '<leader>rl',
        --     '<cmd>lua require("harpoon.tmux").sendCommand("!", ' .. command .. ')<CR>' .. send_r_tmux, opts)

        local to_file = '.." > tmp.log"'
        vim.api.nvim_buf_set_keymap(0, 'n', '<leader>rf',
            '<cmd>lua require("harpoon.tmux").sendCommand("!", ' .. command .. to_file .. ')<CR>' .. send_r_tmux, opts)

    end,
    filetypes = { 'sql' },
    settings = { sqls = {} }
    --     sqls = {
    --         connections = {
    --             -- {
    --             --     name = "bq",
    --             --     driver = "biquery",
    --             --     host = "localhost",
    --             --     port = 443,
    --             --     database = "mk2-prod",
    --             --     projectPaths = {
    --             --         "/home/viktor/hm/research/fog-analysis"
    --             --     }
    --             -- },
    --             -- {
    --             --     driver = 'mysql',
    --             --     -- dataSourceName = 'root:root@tcp(127.0.0.1:13306)/world',
    --             -- },
    --             -- {
    --             --     driver = 'postgresql',
    --             --     -- dataSourceName = 'host=127.0.0.1 port=15432 user=postgres password=mysecretpassword1234 dbname=dvdrental sslmode=disable',
    --             -- },
    --         },
    --     },
    -- },
}
