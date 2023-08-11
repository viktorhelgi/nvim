local M = {
	previous_cmd = nil,
	inlay_hints_on = true,
	toml = require("rust_funcs.toml"),
	tree = require("rust_funcs.tree"),
	run = require("rust_funcs.run"),
	jump = require("rust_funcs.jump"),
	explain_error = require("rust_funcs.explain_error"),
	test_executor = {
        tmux = require("rust_funcs.test_executor"),
    }
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

M.set_inlay_hints = function(v)
    if v then
        vim.cmd("RustEnableInlayHints")
        vim.cmd("RustSetInlayHints")
        M.inlay_hints_on = true
    else
		vim.cmd("RustDisableInlayHints")
		vim.cmd("RustUnsetInlayHints")
		M.inlay_hints_on = false
    end
end

M.toggle_inlay_hints = function()
	if M.inlay_hints_on then
        M.set_inlay_hints(false)
	else
        M.set_inlay_hints(true)
	end
end

M.toggle_inlay_hinst_all_lines = function()
    local is_on = require("rust-tools").config.options.tools.inlay_hints.only_current_line
	if is_on then
		require("rust-tools").config.options.tools.inlay_hints.only_current_line = false
	else
		require("rust-tools").config.options.tools.inlay_hints.only_current_line = true
	end
    M.set_inlay_hints(true)
end

return M
