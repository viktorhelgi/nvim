vim.cmd([[
    autocmd FileType toml lua _G.TomlKeyBindings()
]])

local rust_funcs = require("rust_funcs")
local function _cmd(input)
	return "<CMD>" .. input .. "<CR>"
end

_G.TomlKeyBindings = function()

	require("viktor.config.plugin.neotest").on_attach("python", 0)

	vim.cmd("set colorcolumn=88")

	require("which-key").register({
		c = {
			name = "Change/Cargo",
			-- a = { _cmd("RustCodeAction"), "code-action" },
			b = { _cmd("Task start cargo build"), "build" },
			d = { vim.diagnostic.setqflist, "setqflist" },
			r = { rust_funcs.run.with_arguments, "run --" },
			l = { rust_funcs.run.last_cmd, "run --" },
			s = { _cmd("DiagWindowShow"), "show diagnostic" },
			R = { rust_funcs.run.selected_binary, "run --bin <?>" },
			q = { _cmd("cclose"), "close qflist" },
		},
    })
end
