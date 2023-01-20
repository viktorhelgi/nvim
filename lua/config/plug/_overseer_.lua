
local overseer = require('overseer')
overseer.setup({
    templates = { "user.cpp_build_lib", "user.cpp_build_project" }
})
-- overseer.register_template({
--     name = "piobuild",
--     builder = function(params)
--         return {
--             cmd = { 'pio' },
--             args = { "run", "--verbose" },
--             name = "piobuild",
--             cwd = "",
--             env = {},
--             components = {
--                 "default",
--                 { "on_output_parse", parser = {
--                     -- Put the parser results into the 'diagnostics' field on the task result
--                     diagnostics = {
--                         -- Extract fields using lua patterns
--                         {
--                             "extract",
--                             "^([^%s].+):(%d+):(%d+): (.+)$",
--                             "filename",
--                             "lnum",
--                             "col",
--                             "text"
--                         },
--                     }
--                 } },
--                 "on_result_diagnostics",
--                 { "on_result_diagnostics_quickfix", {
--                     open = true
--                 } }
--             },
--             metadata = {},
--         }
--     end,
--     desc = "Build a platformio project",
--     tags = { overseer.TAG.BUILD },
--     params = {},
--     priority = 50,
--     condition = {
--         filetype = { "c", "cpp", "ino", "h", "hpp", "ini" },
--         callback = function(search)
--             return vim.fn.isdir(search.dir .. "/.pio")
--         end
--     },
-- })
