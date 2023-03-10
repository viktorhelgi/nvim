
require("aerial").setup({
    -- backends = { "treesitter", "lsp", "markdown" },
    -- default_bindings = true,
    -- disable_max_lines = 10000,
    -- disable_max_size = 10000000,
    -- filter_kind = { "Class", "Constructor", "Enum", "Function", "Interface", "Module", "Method", "Struct", },
    -- highlight_mode = "split_width",
    -- highlight_closest = false,
    -- highlight_on_hover = true,
    -- highlight_on_jump = 300,
    -- -- icons = {},
    -- ignore = { unlisted_buffers = true, filetypes = {}, buftypes = "special", wintypes = "special", },
    -- link_folds_to_tree = false,
    -- link_tree_to_folds = true,
    -- manage_folds = false,
    -- nerd_font = "auto",
    -- on_attach = nil,
    -- open_automatic = false,
    -- post_jump_cmd = "normal! zz",
    -- close_on_select = false,
    -- show_guides = false,
    -- update_events = "TextChanged,InsertLeave",
    -- guides = { mid_item = "├─", last_item = "└─", nested_top = "│ ", whitespace = "  ", },
    layout = {
        width = 65,
        -- min_width = 65,
        default_direction = "prefer_left",
        placement = 'edge'
    },
    ignore = {
        filetypes = {
            "lua"
        }
    }
    -- float = {
    --     border = "rounded",
    --     relative = "win",
    --     max_height = 0.9,
    --     height = nil,
    --     min_height = { 8, 0.1 },
    --     override = function(conf)
    --         return conf
    --     end,
    -- },
    -- lsp = {
    --     diagnostics_trigger_update = true,
    --     update_when_errors = true,
    --     update_delay = 300,
    -- },
    -- treesitter = { update_delay = 300, },
    -- markdown = { update_delay = 300, },
})
