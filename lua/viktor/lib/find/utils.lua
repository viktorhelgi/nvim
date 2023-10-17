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

M.term_pattern = M.parent_dir(os.getenv('HOME'))

return M
