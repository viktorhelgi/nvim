local configs = require("rust_funcs").toml.read_configs()

local completions = {}

for _, value in ipairs(configs) do
	if value.crate_types[1] == "bin" then
		table.insert(completions, value)
	end
end

-- vim.print(completions)
---@param item Target
local format = function(item)
	if item.kind[1] == "bin" then
		return string.format("(bin) %s", item.name)
	elseif item.kind[1] == "example" then
		return string.format("(exa) %s", item.name)
	end
end

local opts = {
	prompt = "cargo run --bin <choice>\n------------------------",
	format_item = format,
}

---@param input Target
local on_choice = function(input)
	local exe_type = input.kind[1]
	require("harpoon.tmux").sendCommand("!", "cargo run --" .. exe_type .. " " .. input.name)
end
if #completions == 1 then
	on_choice(completions[1])
	print("cargo run --" .. completions[1].kind[1] .. " " .. completions[1].name)
else
	vim.ui.select(completions, opts, on_choice)
end

-- vim.ui.input({prompt = "cargo run ", completion = "customlist," }, function(input)
--     require('harpoon.tmux').sendCommand('!', "cargo run "..input)
--     -- print("what")
-- end)
