

_G.goto_parent = function(file, parent_filename)

    local project_dir = require('viktor.lib.find').root(file, {parent_filename})
    print(vim.fn.fnamemodify(file, ":t:r"))
    -- require('harpoon.tmux').sendCommand('!', cr..clear..goto_dir..run_exe)
end

