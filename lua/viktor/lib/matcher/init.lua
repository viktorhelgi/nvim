

local function search(text, searchstring)
   local result = {}
   local pattern = searchstring:gsub("*", "\0"):gsub("%p", "%%%0"):gsub("%z", ".-")
   for w in text:gmatch(pattern) do
      table.insert(result, w)
   end
   return result
end


local files = {
    "include/",
    "include/ttime/",
    "include/ttime/exceptions.hpp",
    "include/ttime/timer.hpp",
    "include/ttime/types.hpp",
    "include/ttime/units.hpp",
    "include/ttime/utils.hpp",
    "include/ttime.hpp",
    "src/",
    "src/ttime.cpp",
    "tests/",
    "tests/CMakeLists.txt",
    "tests/test_timer.cpp",
    "tests/test_ttime.cpp",
    "tests/test_types.cpp",
    "tests/test_units.cpp",
}

-- local searchstring = "tests/*.*test_timer.cpp"

local searchstring = "tests/*.*test_timer.cpp"

for i, text in ipairs(files) do
    local result = string.match(text, searchstring)   --> {"function one()", "function two()"}
    print()
    print(i)
    vim.pretty_print(result)
end


