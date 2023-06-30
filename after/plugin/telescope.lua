-- local filebrowser_actions = require("telescope").extensions.file_browser.actions
local telescope = require("telescope")
local actions = require("telescope.actions")
local filebrowser_actions = require("telescope._extensions.file_browser.actions")
local trouble = require("trouble.providers.telescope")

local options = {
	defaults = {
		-- Default configuration for telescope goes here:
		-- config_key = value,
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
				results_width = 0.8,
			},
			vertical = {
				mirror = false,
			},
			width = 0.87,
			height = 0.80,
			preview_cutoff = 120,
		},
		file_ignore_patterns = { "node_modules" },
		path_display = { "truncate" },
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		mappings = {
			i = {
				-- map actions.which_key to <C-h> (default: <C-/>)
				-- actions.which_key shows the mappings for your picker,
				-- e.g. git_{create, delete, ...}_branch for the git_branches picker
				["<C-h>"] = "which_key",
				["<C-p>"] = actions.move_selection_previous,
				["<C-n>"] = actions.move_selection_next,
				["<C-o>"] = actions.toggle_selection,
				["<C-a>"] = actions.add_selected_to_qflist,
				["<C-s>"] = actions.send_selected_to_qflist + actions.open_qflist,
				["<C-j>"] = actions.toggle_selection + actions.move_selection_next,
				["<C-k>"] = actions.toggle_selection + actions.move_selection_previous,
				-- ["<C-b>"] = actions.toggle_selection
			},
			n = {
				-- ["<C-t"] = trouble.open_with_trouble,
				["<C-p>"] = actions.move_selection_previous,
				["<C-n>"] = actions.move_selection_next,
				["<C-o>"] = actions.smart_send_to_qflist,
			},
		},
	},
	pickers = {
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
	},
	extensions_list = {
		"aerial",
		"file_browser",
		"live_grep_args",
		-- "harpoon",
		-- "toggletasks",
		-- "fzf"
	},
	extensions = {
		--     aerial = {
		--         -- Display symbols as <root>.<parent>.<symbol>
		--         show_nesting = {
		--             ['_'] = false, -- This key will be the default
		--             json = true, -- You can set the option for specific filetypes
		--             yaml = true,
		--         }
		--     },
		--     fzf = {
		--       fuzzy = true,                    -- false will only do exact matching
		--       override_generic_sorter = true,  -- override the generic sorter
		--       override_file_sorter = true,     -- override the file sorter
		--       case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
		--                                        -- the default case_mode is "smart_case"
		--     },
		--     -- You don't need to set any of these options.
		--     -- IMPORTANT!: this is only a showcase of how you can set default options!
		file_browser = {
			-- theme = "dropdown",
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
			mappings = {
				["i"] = {
					-- your custom insert mode mappings
					-- ["<c-h>"] = filebrowser_actions.toggle_hidden,
					["<C-r>"] = filebrowser_actions.goto_cwd,
					["<C-b>"] = filebrowser_actions.goto_parent_dir,
					["<C-l>"] = actions.select_default,
					["<C-n>"] = actions.move_selection_next,
					["<C-p>"] = actions.move_selection_previous,
					["<C-x>"] = filebrowser_actions.toggle_hidden,
				},
				["n"] = {
					["n"] = filebrowser_actions.create,
					["<C-n>"] = actions.move_selection_next,
					["<C-p>"] = actions.move_selection_previous,
					["<C-h>"] = filebrowser_actions.goto_parent_dir,
					["h"] = filebrowser_actions.goto_parent_dir,
					["<C-l>"] = actions.select_default,
					["l"] = actions.select_default,
					["H"] = filebrowser_actions.toggle_hidden,
					["<C-x>"] = filebrowser_actions.toggle_hidden,
					["C"] = filebrowser_actions.goto_cwd,
				},
			},
		},
		live_grep_args = {
			auto_quoting = true, -- enable/disable auto-quoting
			-- define mappings, e.g.
			mappings = { -- extend mappings
				i = {
					-- ["<C-f>"] = require("telescope-live-grep-args.actions").quote_prompt(),
					["<C-i>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " --iglob " }),
				},
			},
			-- ... also accepts theme settings, for example:
			-- theme = "dropdown", -- use dropdown theme
			-- theme = { }, -- use own theme spec
			-- layout_config = { mirror=true }, -- mirror preview pane
		},
		--     -- Your extension configuration goes here:
		--     -- extension_name = {
		--     --   extension_config_key = value,
		--     -- }
		--     -- please take a look at the readme of the extension you want to configure
	},
}
-- options = require("core.utils").load_override(options, "nvim-telescope/telescope.nvim")
telescope.setup(options)
-- telescope.setup(options)
--
-- To get telescope-file-browser loaded and working with telescope,
-- you need to call load_extension, somewhere after setup function:
-- require("telescope").load_extension("file_browser")
-- require('telescope').load_extension('aerial')
-- require("telescope").load_extension('harpoon')

pcall(function()
	for _, ext in ipairs(options.extensions_list) do
		telescope.load_extension(ext)
	end
end)
