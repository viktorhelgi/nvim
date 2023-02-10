
M = {}

M.file_exists = function(name)
    local f = io.open(name, "r")
    if f ~= nil then io.close(f) return true else return false end
end

-- https://stackoverflow.com/a/20460403
local function findLast(haystack, needle)
    local i = haystack:match(".*" .. needle .. "()")
    if i == nil then return nil else return i - 1 end
end

M.parent_dir = function(dir)
    return dir:sub(1, findLast(dir, '/') - 1)
end

M.HOME_PATTERN = M.parent_dir(os.getenv('HOME'))



M.root = function(path, patterns)
    if type(path)~='string' then
        error("'path' argument in rooter.find_root_dir() should be a string")
    elseif type(patterns) ~='table' then
        error("'pattern' argument in rooter.find_root_dir() should be a table")
    elseif #patterns == 0 then
        error("'patterns' argument is of len 0")
    end

    while path ~= M.HOME_PATTERN do
        for _, dir in ipairs(patterns) do
            if M.file_exists(path .. '/' .. dir) then
                return path
            end
        end
        path = M.parent_dir(path)
    end

    error("No-match: \npath: "..path)
end
return M
