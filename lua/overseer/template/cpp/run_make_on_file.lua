-- /home/stevearc/.config/nvim/lua/overseer/template/user/cpp_build.lua
local overseer = require('overseer')

_G.get_build_file = function(file)
    local project_dir = require('viktor.lib.find').root(file, { "build" })
    local rel_dir = get_relative_dir(file)
    return project_dir .. "/build" .. rel_dir
    -- local filename = vim.fn.fnamemodify(file, ":t:r")
    -- return project_dir.."/build"..rel_dir.."filename"
end

return {
    name = "Run Make (on file)",
    tags = { overseer.TAG.BUILD },
    builder = function()
        -- Full path to current file (see :help expand())
        local file = vim.fn.expand("%:p")
        return {
            cwd = _G.get_build_file(file),
            cmd = { "make" },
            args = { "-j17" },
            -- args = { vim.fn.fnamemodify(file, ":t:r") },
            components = { { "on_output_quickfix", open = true, set_diagnostics = true }, "default" },
            --   components = {
            -- 	"default",
            -- 	{"on_output_parse", parser = {
            -- 		-- Put the parser results into the 'diagnostics' field on the task result
            -- 		diagnostics = {
            -- 			-- Extract fields using lua patterns
            -- 			{
            -- 				"extract",
            -- 				"^([^%s].+):(%d+):(%d+): (.+)$",
            -- 				"filename",
            -- 				"lnum",
            -- 				"col",
            -- 				"text"
            -- 			},
            -- 		}
            -- 	}},
            -- 	"on_result_diagnostics",
            -- 	{"on_result_diagnostics_quickfix", {
            -- 		open = true
            -- 	}}
            -- },
            -- components = { { "on_result_diagnostics"}, "default" },
        }
    end,
    condition = {
        filetype = { "cpp", "hpp" },
    },
}
