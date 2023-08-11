local utils = require("rust-tools.utils.utils")

local M = {}

function M.execute_command(command, args, cwd)
	local ok, term = pcall(require, "harpoon.tmux")
	if not ok then
		vim.schedule(function()
			vim.notify("toggleterm not found.", vim.log.levels.ERROR)
		end)
		return
	end

    term.sendCommand("!", utils.make_command_from_args(command, args).."\r")
end

return M
