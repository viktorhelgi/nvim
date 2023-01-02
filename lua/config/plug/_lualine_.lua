-- initialize vars for schemes

-- local scheme = {}
-- scheme.lualine_style_left = ''
-- scheme.lualine_style_right = ''
--
-- -- specifies line seperator style
-- scheme.lualine_seperator_left = ''
-- scheme.lualine_seperator_right = ''
--
-- -- tabline styles
-- scheme.tabline_style_left = ''
-- scheme.tabline_style_right = ''
--
-- -- tabline seperator
-- scheme.tabline_seperator_left = ''
-- scheme.tabline_seperator_right = ''

require('lualine').setup({
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = { 'mode' },
        -- lualine_b = { 'diagnostics' },
        lualine_b = {
            {
                'diagnostics',

                -- Table of diagnostic sources, available sources are:
                --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
                -- or a function that returns a table as such:
                --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
                sources = { 'nvim_diagnostic', 'coc' },

                -- Displays diagnostics for the defined severity types
                sections = { 'error', 'warn', 'info', 'hint' },

                diagnostics_color = {
                    -- Same values as the general color option can be used here.
                    error = 'DiagnosticError', -- Changes diagnostics' error color.
                    warn  = 'DiagnosticWarn', -- Changes diagnostics' warn color.
                    info  = 'DiagnosticInfo', -- Changes diagnostics' info color.
                    hint  = 'DiagnosticHint', -- Changes diagnostics' hint color.
                },
                symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
                colored = true, -- Displays diagnostics status in color if set to true.
                update_in_insert = false, -- Update diagnostics in insert mode.
                always_visible = false, -- Show diagnostics even if there are none.
            }
        },
        lualine_c = {
            { 'filename', path = 1 }
        },
        lualine_x = { 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
    },
})
