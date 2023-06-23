local overseer = require("overseer")
return {
	name = "npm start",
	tags = { overseer.TAG.BUILD },
	builder = function()
		-- Full path to current file (see :help expand())
		return {
			cwd = "/home/viktor/hm/web",
			-- cmd = { "npm start --port 8000" },
            cmd = {"npm"},
            args = {"start"},
			-- cmd = { "!npm start --port 8000" },
			-- args = { "-j17" },
			-- args = { vim.fn.fnamemodify(file, ":t:r") },
			-- components = { { "on_output_quickfix", open = true, set_diagnostics=true }, "default" },
			components = {
				"default",
				{
					"on_output_parse",
					parser = {
						-- Put the parser results into the 'diagnostics' field on the task result
						diagnostics = {
							-- Extract fields using lua patterns
							{
								"extract",
								"%EError in %f %l",
								"%C%m",
								-- "^ERROR in ([%s].+) (%d+):(%d+): (.+)$",
								-- "filename",
								-- "lnum",
								-- "col",
								-- "text"
							},
						},
					},
				},
				{ "on_result_diagnostics", {
					remove_on_restart = true,
				} },
				{ "on_result_diagnostics_quickfix", {
					open = true,
				} },
			},
			-- components = { { "on_result_diagnostics" }, "default" },
		}
	end,
	condition = {
		filetype = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
	},
}
