local overseer = require("overseer")
return {
	name = "Run Test for file",
	tags = { overseer.TAG.BUILD },
	builder = function()
		-- Full path to current file (see :help expand())
		local file = vim.fn.expand("%:p")

		local rfile = vim.fn.expand("%:r")
		local module = rfile:sub(rfile:find("/") + 1, -1):gsub("/", "::")
		return {
			-- cwd = require('viktor.lib.find').root(file, { "Cargo.toml" }),
			cwd = vim.fn.getcwd(),
			cmd = { "Task start cargo nextest run " .. module },
			-- args = { "-j17" },
			components = {
				"default",
				{
					"on_output_parse",
					parser = {
						-- diagnostics = {
							{
								"%I--- STDERR:",
								"%C%m",
								"%Z%f",
							},
						-- },
					},
				},
				{ "on_result_diagnostics", {
					remove_on_restart = true,
				} },
				{ "on_result_diagnostics_quickfix", {
					open = true,
				} },
			},
		}
	end,
	condition = {
		filetype = { "rs", "rust" },
	},
}
