M = {}

local Path = require('plenary.path')

---@param path Path
---@return Path
M.get_test_file = function(path)
    if path.filename:find('_spec.lua') == nil then
        local test_filename = vim.fn.fnamemodify(path.filename, ":t:r") .. "_spec.lua"
        return Path:new(path:parent().filename .. "/spec/" .. test_filename)
    else
        return path
    end
end


M.test_file = function()
    ---@type Path
    local file_path = Path:new(vim.fn.expand("%:p"))
    local test_file = M.get_test_file(file_path)

    if test_file:exists() == false then
        print("test file doesn't exist: " .. test_file.filename)
        return nil
    end
    require("harpoon.tmux").sendCommand("!", "^c")
    require("harpoon.tmux").sendCommand("!", "busted " .. test_file .. "\r")
end

return M
