local cmp = require('cmp.init')
local CmpWindow = require('cmp.config.window')
local CmpConfigSources = require("cmp.config.sources")
local lspkind = require('lspkind')


---@type cmp.ConfigSchema
local cmp_setup_global = {
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    window = {
        completion = {
            border = '', --opts.border or 'rounded',

            -- winhighlight = opts.winhighlight or 'Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None',
            -- zindex = opts.zindex or 1001,
            -- col_offset = opts.col_offset or 0,
            -- side_padding = 0 -- opts.side_padding or 0
        },
        documentation = {
            border = 'rounded',
            max_width = 90,
        }
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs( -4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-o>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        -- ['<C-i>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        -- ['<Tab>'] = cmp.mapping({
        --     i = function()
        --         if cmp.visible() then
        --             cmp.mapping.confirm({ select = true })
        --         else
        --             vim.fn.feedkeys('<C-z>', 'nt')
        --             -- vim.fn.feedkeys('    ', 'nt')
        --         end
        --     end }),
    }),
    sources = CmpConfigSources({
        { name = 'nvim_lsp' },
        -- { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {
        { name = 'buffer' },
    })
}



-----------------------------------------------------------------------
-- Rust Rust Rust -----------------------------------------------------
-----------------------------------------------------------------------


---@type cmp.ConfigSchema
local cmp_setup_rust = {
    mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs( -4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<Tab>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = CmpConfigSources({
        { name = 'nvim_lsp' },
        { name = 'path' }
    }, {
        { name = 'buffer' }
    }
    ),
    formatting = {

        ---@param entry cmp.Entry
        ---@param vim_item vim.CompletedItem
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
}
---@type cmp.ConfigSchema
local cmp_setup_git_commit = {
    sources = CmpConfigSources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
        { name = 'buffer' },
    })
}

---@type cmp.ConfigSchema
local cmp_setup_cmdline_slash = {
    mapping = cmp.mapping.preset.cmdline(),
    sources = CmpConfigSources({
        { name = 'nvim_lsp_document_symbol' },
        { name = 'buffer' }
    })
}
-- local mapping_colon = cmp.mapping.preset.cmdline()

-- mappingt_colon

---@type cmp.ConfigSchema
local cmp_setup_cmdline_colon = {
    mapping = {
        ['<Tab>'] = function()
            cmp.select.next_item()
            -- if cmp.visible() then
            --     cmp.select_next_item()
            -- else
            --     vim.fn.feedkeys('<C-z>', 'nt')
            -- end
        end,
    },
    sources = CmpConfigSources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
}

local lspkind_configs = {
    -- defines how annotations are shown
    -- default: symbol
    -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
    mode = 'symbol_text',
    -- default symbol map
    -- can be either 'default' (requires nerd-fonts font) or
    -- 'codicons' for codicon preset (requires vscode-codicons font)
    --
    -- default: 'default'
    preset = 'codicons',
    -- override preset symbols
    --
    -- default: {}
    symbol_map = {
        Text = "", Method = "", Function = "", Constructor = "",
        Field = "ﰠ", Variable = "", Class = "ﴯ", Interface = "",
        Module = "", Property = "ﰠ", Unit = "塞", Value = "",
        Enum = "", Keyword = "", Snippet = "", Color = "",
        File = "", Reference = "", Folder = "", EnumMember = "",
        Constant = "", Struct = "פּ", Event = "", Operator = "",
        TypeParameter = ""
    },
}

cmp.setup(cmp_setup_global)
cmp.setup.filetype('gitcommit', cmp_setup_git_commit)
cmp.setup.cmdline('/', cmp_setup_cmdline_slash)
cmp.setup.cmdline(':', cmp_setup_cmdline_colon)
lspkind.init(lspkind)

cmp.setup.filetype('rust', cmp_setup_rust)
local cmp_lua_setup = cmp_setup_rust
cmp_lua_setup.sources = CmpConfigSources({
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'nvim_lua' }
}, {
    { name = 'buffer' }
})
cmp.setup.filetype('lua', cmp_lua_setup)
cmp.setup.filetype('cpp', cmp_setup_rust)

cmp.setup.filetype('julia', cmp_setup_rust)

-- ---@type cmp.ConfigSchema
-- local cmp_setup_sql = cmp_setup_rust
-- cmp_setup_sql.sources = CmpConfigSources({
--     { name = 'nvim_lsp' },
--     { name = 'path' },
--     { name = 'omni' }
-- }, {
--     { name = 'buffer' }
-- }
-- )
-- cmp_setup_sql.mapping = {
--     ['<C-u>'] = cmp.mapping.scroll_docs( -4),
--     ['<C-d>'] = cmp.mapping.scroll_docs(4),
--     ['<C-e>'] = cmp.mapping.abort(),
--     ['<C-Space>'] = cmp.mapping.complete({
--         config = {
--             sources = {
--                 { name = 'nvim_lsp' }
--             }
--         }
--     }),
--     ['<C-n>'] = cmp.mapping.complete({ config = { sources = { { name = 'omni' } } } }),
--     ['<C-f>'] = cmp.mapping.complete({ config = { sources = { { name = 'path' } } } })
-- }
--
-- cmp.setup.filetype('sql', cmp_setup_sql)
