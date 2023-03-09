
local status, err = pcall(function()

    local telescope = require('telescope')


    telescope.setup(require('config.plug.setup_configs.telescope'))


    telescope.load_extension('changed_files')
    telescope.load_extension('fzf')
    telescope.load_extension "file_browser"
end)

if not status then
    print("Telescope Setup ERROR: \n"..err)
end
