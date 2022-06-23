local cmp = require('cmp.init')
local CmpWindow = require('cmp.config.window')
local CmpConfigSources = require("cmp.config.sources")
local lspkind = require('lspkind')


---@type cmp.ConfigSchema
local cmp_setup_global = {
    window = {
        completion = CmpWindow.bordered({
            border = 'rounded', --opts.border or 'rounded',
            -- winhighlight = opts.winhighlight or 'Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None',
            -- zindex = opts.zindex or 1001,
            -- col_offset = opts.col_offset or 0,
            side_padding = 0 -- opts.side_padding or 0
        }),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = CmpConfigSources({
        { name = 'nvim_lsp' },
        -- { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
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
    mapping = cmp.mapping.preset.cmdline(),
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
        { name = 'buffer' }
    })
}
---@type cmp.ConfigSchema
local cmp_setup_cmdline_colon = {
    mapping = cmp.mapping.preset.cmdline(),
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
cmp.setup.filetype('rs', cmp_setup_rust)


