local overseer = require("overseer")
overseer.setup({
	-- component_aliases = {
	-- 	default = {
	-- 		-- "on_output_summarize",
	-- 		-- "on_exit_set_status",
	-- 		-- "on_complete_notify",
	-- 		-- "on_complete_dispose",
	-- 		-- This puts the parsed results into the quickfix
	-- 		{ "on_result_diagnostics_quickfix", open = true },
	-- 		-- This puts the parsed results into neovim's diagnostics
	-- 		"on_result_diagnostics",
	-- 	},
	-- },
	-- -- templates = { "cpp.run_cmake", "cpp.run_make", "cpp.run_make_on_file" }
})
-- overseer.run_template()
overseer.load_template("cpp.run_cmake")
overseer.load_template("cpp.run_make")
overseer.load_template("cpp.run_make_on_file")
overseer.load_template("personal.rust-tools-runnables")
-- overseer.add_template_hook

overseer.load_template("rust.test_file")
overseer.load_template("python.ruff_lint")
overseer.load_template("npm.start")
-- overseer.add_template_hook({ module = "^cargo$" }, function(task_defn, util)
-- 	util.add_component(task_defn, { "on_output_quickfix", open = true, set_diagnostics = true })
-- end)

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
