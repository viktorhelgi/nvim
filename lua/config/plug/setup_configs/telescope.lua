
--- 'telescope.actions'
local actions = require('telescope.actions')

--- 'telescope.extensions.file_browser.actions'
local actions_fb = require('telescope').extensions.file_browser.actions

return {
    defaults = {
        file_ignore_patterns = {
            "%.png", "%.jpeg", "%.svg", "%.md"
        },
        preview = {
            filesize_limit = 1;
        },
        -- buffer_previewer_maker = new_maker,
        prompt_prefix = '=> ',
        selection_caret = ' > ',
        entry_prefix = '   ',
        -- borderchars = { '═', '│', '═', '│', '╒', '╕', '╛', '╘' },
        sorting_strategy = "ascending",
        mappings = {
            n = {
                ["<C-b>"] = actions.cycle_previewers_next,
                ["<C-l>"] = actions.cycle_previewers_prev,
                ["<C-n"] = actions.move_selection_next,
                ["<C-p"] = actions.move_selection_previous,
                ["<C-s>"] = actions.send_selected_to_qflist + actions.open_qflist,
                ["<C-a>"] = actions.add_selected_to_qflist,
                ["j"] = actions.toggle_selection + actions.move_selection_next,
                ["k"] = actions.toggle_selection + actions.move_selection_previous
            },
            i = {
                ["<C-n"] = actions.move_selection_next,
                ["<C-p"] = actions.move_selection_previous,
                ["<C-s>"] = actions.send_selected_to_qflist + actions.open_qflist,
                ["<C-a>"] = actions.add_selected_to_qflist,
                ["<C-j>"] = actions.toggle_selection + actions.move_selection_next,
                ["<C-k>"] = actions.toggle_selection + actions.move_selection_previous
            },
        },
        layout_strategy = 'horizontal',
        layout_config = {
            prompt_position = 'top',
            height = 35,
            width = 0.6,
            -- preview_width = 88,
            horizontal = {
                height = 45,
                width = 160
            }
        },


        borderchars = {
            -- Default: { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
            prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            results = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            -- results = { '─', '', '─', '│', '╭', '─', '─', '╰' },
            -- preview = { '─', '│', '─', '│', '╭', '╮', '╯', '┴' },
        },
    },
    extensions = {
        -- fzf = {
        -- 	fuzzy = true,
        -- 	override_genearic_sorter = true,
        -- 	override_file_sorter = true,
        -- 	case_mode = 'smart_case',
        -- },
        file_browser = {
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = false,
            mappings = {
                ["i"] = {
                    ["<C-n>"] = actions.move_selection_next,
                    ["<C-p>"] = actions.move_selection_previous,
                    ["<C-b>"] = actions_fb.goto_parent_dir,
                    -- your custom insert mode mappings
                },
                ["n"] = {
                    ["n"] = actions_fb.create,
                    ["<C-n>"] = actions.move_selection_next,
                    ["<C-p>"] = actions.move_selection_previous,
                    -- your custom normal mode mappings
                },
            },
        },
    },
}
