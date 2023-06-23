local M = {}
---@class CargoToml
---@field name string
---@field version string
---@field id string
---@field license string
---@field license_file string
---@field description string
---@field source string
---@field dependencies Dependency[]
---@field targets Target[]
---@field features Feature
---@field manifest_path string
---@field metadata string
---@field publish string
---@field authors string[]
---@field categories string[]
---@field keywords string[]
---@field readme string
---@field repository string
---@field homepage string
---@field documentation string
---@field edition string
---@field links string[]
---@field default_run string
---@field rust_version string

---@class Feature

---@class Dependency
---@field name string
---@field source string
---@field req string
---@field kind string
---@field rename string
---@field optional boolean
---@field uses_default_features boolean
---@field target string
---@field registry string

---@class Target
---@field crate_types string[]
---@field doc boolean
---@field doctest boolean
---@field edition string
---@field kind string[]
---@field name string
---@field required-features string[]
---@field src_path string
---@field test boolean

local function has_value(tab, val)
	for _, value in ipairs(tab) do
		if value == val then
			return true
		end
	end

	return false
end

M.read_configs = function()
    local tmpfile = ".tmpsatnheua.json"
	vim.cmd("silent ! cargo read-manifest > "..tmpfile)
    ---@type CargoToml|nil
	local cargo_toml = vim.fn.json_decode(vim.fn.readfile(tmpfile))
    os.remove(tmpfile)
    return cargo_toml
end

M.get_examples_configs = function()
    local cargo_toml = M.read_configs()

    ---@type Target[]
    local examples = {}

	for _, target in ipairs(cargo_toml.targets) do
		if has_value(target.kind, "example") then
            table.insert(examples, target)
		end
	end
    return examples
end

M.get_required_features_for_ex = function(example_name)
    ---@type Target
    local example

    for _, conf in ipairs(M.get_examples_configs()) do
        if conf.name == example_name then
            example = conf
        end
    end

    return example["required-features"]
end
return M
