
local ppath = require('plenary.path')

local M = {}

---@param file_path string 
---@param specified_directory string 
---@return boolean
M.file_is_child_of_directory = function(file_path, specified_directory)

    ---@class Path
    local p = ppath:new(file_path)
    local count = 0

    while (true) do
        p =  p:parent()
        if (p.filename == specified_directory) then
            print('true')
            return true
        elseif (p.filename == "/") then
            print("false")
            return false
        end
        count = count + 1
        if (count == 1000) then
            error("\n\nError while detecting file-type")
        end
    end
end
return M
