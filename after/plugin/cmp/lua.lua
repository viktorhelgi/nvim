local lspkind = require("lspkind")

local cmp = require("cmp")
local types = require("cmp.types")
local CmpConfigSources = require("cmp.config.sources")

cmp.setup.filetype("lua", {
    mapping = cmp.mapping.preset.insert({
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        -- ['<C-Space>'] = cmp.mapping.complete({}),
        ["<C-e>"] = cmp.mapping.abort(),
		["<C-o>"] = cmp.mapping.complete({}),
        ["<C-y>"] = cmp.mapping.confirm({
            behavior = types.cmp.ConfirmBehavior.Insert,
            select = true,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = CmpConfigSources({
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "path" },
    --     { name = "buffer" },
    }),
    formatting = {
        ---@param entry cmp.Entry
        ---@param vim_item vim.CompletedItem
        format = function(entry, vim_item)
            -- fancy icons and a name of kind
            -- entry.get_word
            vim_item.kind = lspkind.presets.default[vim_item.kind] .. " " .. vim_item.kind
            -- set a name for each source
            vim_item.menu = ({
                -- buffer = "「Buffer」",
                nvim_lsp = "「Lsp」",
                -- luasnip = "「luasnip」",
            })[entry.source.name]

            vim_item.menu = entry:get_completion_item().detail
            return vim_item
        end,
    },
})

