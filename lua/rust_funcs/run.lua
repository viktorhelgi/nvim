local M = {
    _last_cmd = "cargo run --"
}

local tmux = require("harpoon.tmux")

local run = function(command)
    tmux.sendCommand("1", "^c")
    M._last_cmd = command
    tmux.sendCommand("1", M._last_cmd.."\r")
end

---@param tg Target
local format = function(tg)
	if tg.kind[1] == "bin" then
		return string.format("(bin) %s", tg.name)
	elseif tg.kind[1] == "example" then
		return string.format("(exa) %s", tg.name)
	end
end

M.selected_binary = function()
	local configs = require("rust_funcs").toml.read_configs()
	if configs == nil then
		print("Unable to read cargo manifest")
		return nil
	end

	local completions = {}
	for _, tg in ipairs(configs.targets) do
		if tg.crate_types[1] == "bin" then
			table.insert(completions, tg)
		end
	end

	local opts = {
		prompt = "cargo run \n---------",
		format_item = format,
	}

	---@param tg Target
	local get_cmd = function(tg)
		return "cargo run --" .. tg.kind[1] .. " " .. tg.name
	end


	if #completions == 1 then
		local cmd = get_cmd(completions[1])
		run(cmd)
	else
		vim.ui.select(completions, opts, function(tg)
			run(get_cmd(tg))
		end)
	end
end

M.with_arguments = function()
	---@param input Target
	local func = function(input)
        if input ~= nil then
            run("cargo run -- " .. input)
        end
	end
	vim.ui.input({ prompt = "cargo run -- " }, func)
end

M.last_cmd = function()
	run(M._last_cmd)
end

M.something_good = function()
	if vim.fn.expand("%:h") == "examples" then
		local ex_name = vim.fn.expand("%:t:r")
		vim.print(ex_name)
		tmux.sendCommand("1", "\rcargo run --example " .. ex_name .. "\r")
	else
		local configs = require("rust_funcs").toml.read_configs()
		if configs == nil then
			print("Unable to read cargo manifest")
			return nil
		end

		local targets = {}
		for _, tg in ipairs(configs.targets) do
			--- needs refactoring
			if tg.kind[1] == "bin" then
				table.insert(targets, tg.name)
			end
		end

		if 1 < #targets then
			vim.ui.select(targets, { prompt = "Select" }, function(choice)
				run("cargo run --bin " .. choice .. "\r")
			end)
		else
			run("cargo run --bin " .. targets[1] .. "\r")
		end
		print("no targets found")
	end
end

return M
