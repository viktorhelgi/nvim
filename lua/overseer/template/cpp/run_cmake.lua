local overseer = require('overseer')
local parser = require('overseer')
return {
    name = "Run CMake",
    tags = { overseer.TAG.BUILD },
    builder = function()
        -- Full path to current file (see :help expand())
        local file = vim.fn.expand("%:p")
        return {
            cwd = require('viktor.lib.find').root(file, { "build" }),
            cmd = { "cmake" },
            args = { "-B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .." },
            -- args = { vim.fn.fnamemodify(file, ":t:r") },
            -- components = { { "on_output_quickfix", open = true, set_diagnostics=true }, "default" },
            components = {
                "default",
                { "on_output_parse", parser = {
                    --     -- Put the parser results into the 'diagnostics' field on the task result
                    --     -- overseer.
                    --     -- diagnostics = {
                    --     --     -- Extract fields using lua patterns
                    {
                        "extract",
                        -- "%IDone",
                        -- "%ECMake Error at %f:%l\\ %m:",
                        -- "%C  Target %o",
                        -- "%Z  %m",
                        -- "%I  %f:%l %m",
                        -- "%-G\\s%#",
                        ' %#%f:%l %#(%m)',
                        ',%E','CMake Error at %f:%l (%m):',
                        ',%Z','Call Stack (most recent call first):',
                        ',%C',' %m'
                    },
                    -- }
                } },
                { "on_output_quickfix", open = true, set_diagnostics=true },
                -- "on_result_diagnostics",
                -- { "on_output_quickfix", open = true, set_diagnostics=true },
                -- { "on_result_diagnostics_quickfix", {
                --     open = true
                -- } }
            },
            -- components = { { "on_result_diagnostics" }, "default" },
        }
    end,
    condition = {
        filetype = { "cpp", "hpp" },
    },
}
