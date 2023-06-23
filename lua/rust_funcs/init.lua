local M = {
	previous_cmd = nil,
	inlay_hints_on = true,
	toml = require("rust_funcs.toml"),
	tree = require("rust_funcs.tree"),
	run = require("rust_funcs.run"),
	jump = require("rust_funcs.jump"),
}

M.cargo_run = function()
	local root_dir = vim.fn.expand("%:~:.")
	-- local root_dir = vim.fn.fnamemodify("/home/viktor/hm/research/route-guidance-analysis/bathymetry/src/main.rs", ":~:.")
	while true do
		root_dir = vim.fn.fnamemodify(root_dir, ":h")
		if root_dir:find("/") == nil then
			break
		end
	end

	require("harpoon.tmux").sendCommand("!", "^c")
	if root_dir == "src" then -- We are in a normal rust-project
		M.previous_cmd = "cargo run\r"
	else -- We are in a rust workspace-project
		M.previous_cmd = "cargo run --bin " .. root_dir .. " \r"
	end
	require("harpoon.tmux").sendCommand("!", M.previous_cmd)
end

M.cargo_run_last = function()
	if M.previous_cmd == nil then
		print("No run has been performed")
		return
	end
	require("harpoon.tmux").sendCommand("!", "^c")
	require("harpoon.tmux").sendCommand("!", M.previous_cmd)
end

M.toggle_inlay_hints = function()
	if M.inlay_hints_on then
		vim.cmd("RustDisableInlayHints")
		vim.cmd("RustUnsetInlayHints")
		M.inlay_hints_on = false
	else
		vim.cmd("RustEnableInlayHints")
		vim.cmd("RustSetInlayHints")
		M.inlay_hints_on = true
	end
end

return M
