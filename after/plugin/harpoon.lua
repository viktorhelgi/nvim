
require("harpoon").setup({
    menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
    },
    mark_branch = true,
    tabline = true,
    tabline_prefix = "  ",
    tabline_suffix = "  "
})

local function jump_to_mark(id)
    require('harpoon.ui').nav_file(id)
end

for i = 0, 15 do
    local lhs = i .. "<leader>"
    local map = ":lua require('harpoon.ui').nav_file(" .. i ..")<CR>"
    vim.keymap.set('n', lhs, map, { desc = "harpoon "..i, noremap = true, silent = true })
end

