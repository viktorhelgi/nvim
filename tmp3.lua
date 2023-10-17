---@class Example
---@field name string
---@field path string
---@field features string[]

local function has_value(tab, val)
	for index, value in ipairs(tab) do
		if value == val then
			return true
		end
	end

	return false
end

local function read_json()
    local tmpfile = ".tmpsatnheua.json"
	vim.cmd("! cargo read-manifest > "..tmpfile)
	local cargo_toml = vim.fn.json_decode(vim.fn.readfile(tmpfile))
    os.remove(tmpfile)

	if cargo_toml == nil then
		return nil
	end

    ---@type Example[]
    local examples = {}

	for _, target in ipairs(cargo_toml.targets) do
		if has_value(target.kind, "example") then
            ---@type Example
            -- local ex = {
            --     name = target["name"],
            --     path = target["src_path"],
            --     features = target["required-features"]
            -- }
            table.insert(examples, target)
		end
	end
    vim.pretty_print(examples)

end
read_json()
