local M = {
	_last_cmd = "cargo run --",
}

local tmux = require("harpoon.tmux")

local run = function(command)
	tmux.sendCommand("1", "^c")
	M._last_cmd = command
	tmux.sendCommand("1", M._last_cmd .. "\r")
end

M.command = function(command)
    if type(command) ~= "string" then
        error("The Input should be of type 'string' not " + type(command))
        return nil
    end
    run(command)
end


M.selected_binary = function()
	local configs = require("rust_funcs").toml.read_configs()
	if configs == nil then
		print("Unable to read cargo manifest")
		return nil
	end

	local items = {}
	for _, tg in ipairs(configs.targets) do
		vim.print()
		if tg.crate_types[1] == "bin" then
			tg.build_profile = "dev"
			table.insert(items, { name = tg.name, kind = tg.kind, crate_types = tg.crate_types, build_profile = "dev" })
			if tg.kind[1] == "bin" then
				table.insert(
					items,
					{ name = tg.name, kind = tg.kind, crate_types = tg.crate_types, build_profile = "release" }
				)
			end
		end
	end

	---@param tg Target
	local get_cmd = function(tg)
		if tg.kind[1] == "bin" or tg.kind[1] == "example" then
			if tg.build_profile == "release" then
				return "cargo run --release --features dev --" .. tg.kind[1] .. " " .. tg.name
			else
				return "cargo run --" .. tg.kind[1] .. " " .. tg.name
			end
		elseif tg.kind[1] == "bench" then
			return "cargo bench --bench  --features dev " .. tg.name
		end
	end

	local format_item = function(tg)
		if tg.kind[1] == "bin" then
			return string.format("(bin) %s", tg.name)
		elseif tg.kind[1] == "example" then
			return string.format("(exa) %s", tg.name)
		elseif tg.kind[1] == "bench" then
			return string.format("(ben) %s", tg.name)
		end
	end

	if #items == 1 then
		local cmd = get_cmd(items[1])
		run(cmd)
	else
		vim.ui.select(items, {
			prompt = "cargo run \n---------",
			format_item = function(tg)
				local prompt_item = format_item(tg)
				if tg.build_profile == "release" then
					return prompt_item .. " - release"
				else
					return prompt_item
				end
			end,
		}, function(tg)
			local cmd = get_cmd(tg)
			run(cmd)
		end)
	end
end

-- M.

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
				run("cargo run  --features dev --bin " .. choice .. "\r")
			end)
		else
			run("cargo run --features dev --bin " .. targets[1] .. "\r")
		end
		print("no targets found")
	end
end

M.rust_tools_executor = {}

M.rust_tools_executor.execute_command = function(
	command,
	args,
	_ --[[cwd]]
)
	local ok, term = pcall(require, "harpoon.tmux")
	if not ok then
		vim.schedule(function()
			vim.notify("toggleterm not found.", vim.log.levels.ERROR)
		end)
		return
	end

	local cmd = require("rust-tools.utils.utils").make_command_from_args(command, args)
	-- M._last_cmd = cmd
    run(cmd)
	-- term.sendCommand("!", cmd .. "\r")
end

M.nearest_test = function()
    local tree = require('neotest').run.get_tree_from_args({}, true)
	if tree == nil then
        print("Error: data is nil")
        return
    end
    local data = tree:data()
    local id = data.id

    -- local cmd = "cargo test --package route-guidance --lib -- "..id.." --exact --nocapture"
    local cmd = "cargo test --features dev --package route-guidance --lib -- "..id.." --nocapture"
    -- local cmd = "cargo nextest run --lib "..id.." --no-capture"
    run(cmd)

end

return M
