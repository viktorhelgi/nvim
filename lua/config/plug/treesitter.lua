local ts_config = require('nvim-treesitter.configs')


ts_config.setup({
	-- A list of parser names, or "all"
	ensure_installed = { 'lua', 'python', 'cpp'},

	-- Install languages synchronously (only applied to `ensure_installed`)
	sync_install = true,

	-- List of parsers to ignore installing
	ignore_install = {},

	highlight = {
		-- `false` will disable the whole extension
		enable = true,

		-- list of language that will be disabled
		disable = {},

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
	-- #########################################
	-- Viktor Configs
	textobjects = {
		lsp_interop = {
			enable = true,
			border = 'none',
			peek_definition_code = {
				-- ["<leader>pd"] = "@function.outer",
				["gp"] = "@function.outer",
				-- ["<leader>po"] = "@class.outer",
				-- ["g1"] = "@block.inner",
				-- ["g2"] = "@block.outer",
				-- ["g3"] = "@call.inner",
				-- ["g4"] = "@call.outer",
				-- ["g6"] = "@class.inner",
				-- ["g7"] = "@class.outer",
				-- ["g8"] = "@comment.outer",
				-- ["g9"] = "@conditional.inner",
				["g1"] = "@conditional.outer",
				["g2"] = "@frame.inner",
				["g3"] = "@frame.outer",
				["g4"] = "@function.inner",
				["g6"] = "@function.outer",
				["g7"] = "@loop.inner",
				["g8"] = "@loop.outer",
				["g9"] = "@parameter.inner",
				-- ["gx"] = "@parameter.outer",
				-- ["gx"] = "@scopename.inner",
				-- ["gx"] = "@statement.outer",
			}
		}
	},
})
