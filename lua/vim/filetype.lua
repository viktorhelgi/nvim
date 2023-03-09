local libs = require('viktor.vim.libs')

vim.filetype.add({
  extension = {
    conf = function(path, _)
        local conf_pairs = {
            { filetype = "tmux", directory = "/home/viktorhg/.config/tmux" }
        }
        for _, item in pairs(conf_pairs) do
            if (libs.file_is_child_of_directory(path, item.directory)) then
                return item.filetype
            end
        end
        return "conf"
    end,
    fish = "bash"
  },
})
