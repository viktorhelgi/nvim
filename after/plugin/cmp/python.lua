local lspkind = require("lspkind")

local cmp = require("cmp")
local types = require("cmp.types")
local CmpConfigSources = require("cmp.config.sources")

local cmp_source = function(wanted_kind)
	return cmp.config.sources({
				{
					name = "nvim_lsp",
					entry_filter = function(entry, _)
						local label = entry.completion_item.label
						local received_kind = require("cmp.types").lsp.CompletionItemKind[entry:get_kind()]

						if wanted_kind == "Property" then
							if string.sub(label, 0, 1) == "_" then
								return false
							end
                            return true
							-- return received_kind == "Variable"
                        else
                            return received_kind == wanted_kind
                        end
                        return false
					end,
				},
			})
end

local cmp_source_argument = function()
	return cmp.config.sources({
				{
					name = "nvim_lsp",
					entry_filter = function(entry, _)
						local label = entry.completion_item.label
						local received_kind = require("cmp.types").lsp.CompletionItemKind[entry:get_kind()]

						if "Variable" == received_kind then
							if string.sub(label, -1,-1) == "=" then
								return true
							end
						end
                        return false
					end,
				},
			})
end

cmp.setup.filetype("python", {
    mapping = cmp.mapping.preset.insert({
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		-- ['<C-Space>'] = cmp.mapping.complete({}),
		["<C-e>"] = cmp.mapping.abort(),
		-- ["<C-o>"] = cmp.mapping.complete(),

		["<C-o>"] = cmp.mapping.complete(),
		-- ["<C-o>"] = cmp.mapping.complete({
		-- 	config = {
  --               mapping = cmp.mapping.preset.insert({
  --                   ["<C-n>"] = cmp.mapping.select_next_item(),
  --                   ["<C-p>"] = cmp.mapping.select_prev_item(),
  --               }),
  --               sources = CmpConfigSources({
  --                   { name = "nvim_lsp" },
  --                   { name = "nvim_lsp_signature_help" },
  --                   { name = "path" },
                    -- { name = "buffer" },
  --               }),
		-- 	},
		-- }),
        ["<C-a><C-f>"] = cmp.mapping.complete({
            config = {
                mapping = cmp.mapping.preset.insert({
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                }),
                sources = cmp_source("Function")
            }
        }),
        ["<C-a><C-v>"] = cmp.mapping.complete({
            config = {
                mapping = cmp.mapping.preset.insert({
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                }),
                sources = cmp_source("Variable")
            }
        }),
        ["<C-a><C-p>"] = cmp.mapping.complete({
            config = {
                mapping = cmp.mapping.preset.insert({
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                }),
                sources = cmp_source("Property")
            }
        }),
        ["<C-a><C-i>"] = cmp.mapping.complete({
            config = {
                mapping = cmp.mapping.preset.insert({
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                }),
                sources = cmp_source_argument("Property")
            }
        }),

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

