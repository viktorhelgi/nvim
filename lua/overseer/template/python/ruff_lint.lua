local overseer = require("overseer")
return {
	name = "Ruff Lint",
	tags = { overseer.TAG.BUILD },
	builder = function()
		return {
			-- cwd = require('viktor.lib.find').root(file, { "Cargo.toml" }),
			cwd = vim.fn.getcwd(),
            -- cwd = vim.fn.expand('%:p:h'),
            -- cwd = "/home/viktor/hm/backend/functions",
			cmd = "/home/viktor/.local/share/nvim/mason/bin/ruff .",
			-- args = { "-j17" },
			components = {
				"default",
            	{"on_output_parse", parser = {
            		-- Put the parser results into the 'diagnostics' field on the task result
            		diagnostics = {
            			-- Extract fields using lua patterns
            			{
                                "extract_efm",
                                {
                                    "%f:%l:c: %n %m"
                                    -- test = function() end
                                }
            			},
            		}
            	}},
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
		filetype = { "py", "python" },
	},
}
