-- Requires:
--      https://crates.io/crates/cargo-modules
-- Run:
--      cargo install cargo-modules
local M = {}

local cmd = "cargo modules generate tree "

local tmux = require("harpoon.tmux")

M.options = {
	types = "types",
	traits = "traits",
	functions = "fns",
}

local tree = function(lib_or_bin)
	if lib_or_bin ~= "bin" and lib_or_bin ~= "lib" then
		print("lib_or_bin should either be equal to 'bin' or 'lib'")
		return nil
	end
    local choices = {"types", "traits", "functions"}
	vim.ui.select(choices, { prompt = "cargo modules generate tree" }, function(choice)
		tmux.sendCommand("!", "^c")
		tmux.sendCommand("!", cmd .. " --" .. lib_or_bin .. " --" .. M.options[choice].."\r")
	end)
end

M.lib = function()
	tree("lib")
end
-- M.bin = function()
-- 	tree("bin")
-- end

M.show = function()
	vim.ui.input({ prompt = cmd }, function(input)
		tmux.sendCommand("!", "^c")
		tmux.sendCommand("!", cmd .. input .. "\r")
	end)
end

return M
