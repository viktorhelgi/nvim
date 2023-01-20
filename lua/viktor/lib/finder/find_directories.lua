


M = {}
local utils = require('viktor.lib.alternate.find.utils')


M.which_match = function(path, patterns)
    if type(path)~='string' then
        error("path argument in rooter.find_root_dir() should be a string")
    elseif type(patterns) ~='table' then
        error("path argument in rooter.find_root_dir() should be a string")
    elseif #patterns == 0 then
        error("'patterns' argument is of len 0")
    end


    local matches = {}
    while path ~= utils.term_pattern do
        for _, dir in ipairs(patterns) do
            if utils.file_exists(path .. '/' .. dir) then
                table.insert(matches, path)
            end
        end
        path = utils.parent_dir(path)
    end

    return matches
end
return M
