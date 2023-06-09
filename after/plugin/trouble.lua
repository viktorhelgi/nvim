-- M = {}

-- vim.keymap.set(mode, bind, '<cmd>'..req..cmd..'<cr>')

local km_s = 'lua vim.api.nvim_set_keymap'
local km_d = 'vim.keymap.del'

--local km = vim.keymap



_G.set_cool_keymap = function()
    vim.keymap.set('n', 'n', '<cmd>cn<cr>')
    vim.keymap.set('n', 'N', '<cmd>cp<cr>')
end
_G.del_cool_keymap = function()
    vim.keymap.del('n', 'n')
    vim.keymap.del('n', 'N')
end

-- local set_cmd1 = ':'..km_s..'("n", "n", \':cn<cr>\')<CR>'
-- local set_cmd2 = ':'..km_s..'("n", "N", \':cp<cr>\')<CR>'
-- vim.api.nvim_set_keymap('n', '<leader>c/', '<cmd>', {})

-- require('viktor.lib.funcs').cmd_mappings('n',
--     {
--         ['<leader>'] = {
--             ['c'] = {
--                 ['o'] = '[cmd] TroubleToggle',
--                 ['q'] = '[cmd] TroubleToggle quickfix',
--                 ['l'] = '[cmd] TroubleToggle loclist',
--                 ['w'] = '[cmd] TroubleToggle workspace_diagnostics',
--                 ['d'] = '[cmd] TroubleToggle document_diagnostics',
--                 ['r'] = '[cmd] TroubleToggle lsp_references',
--                 ['n'] = '[cmd] lua require("trouble").next({skip_groups = true, jump = true})',
--                 ['p'] = '[cmd] lua require("trouble").previous({skip_groups = true, jump = true})',
--                 ['/'] = '[cmd] lua _G.set_cool_keymap()',
--                 ['?'] = '[cmd] lua _G.del_cool_keymap()',
--                 -- ['?'] = ':'..km_d..'("n", "n")<CR>:'..km_d..'("n", "N")<CR>',
--                 -- ['f'] = '[cmd] lua require("trouble").first({skip_groups = true, jump = true})',
--                 -- ['l'] = '[cmd] lua require("trouble").last({skip_groups = true, jump = true})',
--             },
--         }
--     }
-- )
local trouble = pcall(require, 'trouble')
if trouble ~= nil then
    require('trouble').setup({
        position = "bottom", -- position of the list can be: bottom, top, left, right
        height = 10, -- height of the trouble list when position is top or bottom
        width = 50, -- width of the list when position is left or right
        icons = true, -- use devicons for filenames
        mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
        fold_open = "", -- icon used for open folds
        fold_closed = "", -- icon used for closed folds
        group = true, -- group results by file
        padding = true, -- add an extra new line on top of the list
        action_keys = { -- key mappings for actions in the trouble list
            -- map to {} to remove a mapping, for example:
            -- close = {},
            close = "q", -- close the list
            cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
            refresh = "r", -- manually refresh
            jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
            open_split = { "<c-s>" }, -- open buffer in new split
            open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
            open_tab = { "<c-t>" }, -- open buffer in new tab
            jump_close = { "o" }, -- jump to the diagnostic and close the list
            toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
            toggle_preview = "P", -- toggle auto_preview
            hover = "K", -- opens a small popup with the full multiline message
            preview = "p", -- preview the diagnostic location
            close_folds = { "zM", "zm" }, -- close all folds
            open_folds = { "zR", "zr" }, -- open all folds
            toggle_fold = { "zA", "za" }, -- toggle fold of current file
            previous = "k", -- previous item
            next = "j" -- next item
        },
        indent_lines = true, -- add an indent guide below the fold icons
        auto_open = false, -- automatically open the list when you have diagnostics
        auto_close = false, -- automatically close the list when you have no diagnostics
        auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
        auto_fold = false, -- automatically fold a file trouble list at creation
        auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
        signs = {
            -- icons / text used for a diagnostic
            -- error = "",
            -- warning = "",
            -- hint = "",
            -- information = "",
            -- other = ""
            error = "E",
            warning = "W",
            hint = "H",
            information = "I",
            other = "?"
        },
        use_diagnostic_signs = true -- enabling this will use the signs defined in your lsp client
    })
end
