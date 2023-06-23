local lspkind = require("lspkind")

local cmp = require("cmp")
local types = require("cmp.types")
local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
local CmpConfigSources = require("cmp.config.sources")

cmp.setup.filetype("sql", {
	snippet = {
		expand = function(args)
			vim.fn["UltiSnips#Anon"](args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		-- ['<C-Space>'] = cmp.mapping.complete({}),
		["<C-e>"] = cmp.mapping.abort(),
		["<C-o>"] = cmp.mapping.complete(),
		-- ["<C-a>"] = cmp.mapping.complete({config = {sources={name = "ultisnips"}}}),
		["<C-s>"] = cmp.mapping.complete({
			config = {
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
				}),
				sources = CmpConfigSources({
					{ name = "ultisnips" },
				}),
			},
		}),
		["<C-y>"] = cmp.mapping.confirm({
			behavior = types.cmp.ConfirmBehavior.Insert,
			select = true,
		}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<Tab>"] = cmp.mapping(function(fallback)
			cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
		end, {
			"i",
			"s", --[[ "c" (to enable the mapping in command mode) ]]
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			cmp_ultisnips_mappings.jump_backwards(fallback)
		end, {
			"i",
			"s", --[[ "c" (to enable the mapping in command mode) ]]
		}),
		-- ["<Tab>"] = cmp.mapping(function(fallback)
		--           if cmp.visible() then
		-- 	    cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
		--           end
		--           fallback()
		-- end, {
		-- 	"i",
		-- 	"s", --[[ "c" (to enable the mapping in command mode) ]]
		-- }),
		-- ["<S-Tab>"] = cmp.mapping(function(fallback)
		--           if cmp.visible() then
		-- 	    cmp_ultisnips_mappings.jump_backwards(fallback)
		--           end
		--           fallback()
		-- end, {
		-- 	"i",
		-- 	"s", --[[ "c" (to enable the mapping in command mode) ]]
		-- }),
	}),
	sources = CmpConfigSources({
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "path" },
		{ name = "ultisnips" },
	}),
	formatting = {
		---@param entry cmp.Entry
		---@param vim_item vim.CompletedItem
		format = function(entry, vim_item)
			-- fancy icons and a name of kind
			-- entry.get_word
			vim_item.kind = lspkind.presets.default[vim_item.kind] .. " " .. vim_item.kind
			-- set a name for each source
			vim_item.abbr = string.sub(vim_item.abbr, 1, 60)
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
