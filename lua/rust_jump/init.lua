local M = {
	last_search = "",
}

local all = { "impl", "struct", "struct<T>", "async fn", "async fn<T>", "fn", "fn<T>", "trait", "enum", "impl<T>" }
local impl = { "impl", "impl<T>" }
local struct = { "struct", "struct<T>" }
local fn = { "async fn", "async fn<T>", "fn", "fn<T>" }
local trait = { "trait", "trait<T>" }
local enum = { "enum", "enum<T>" }
local mod_use = { "mod", "use" }

local pub_all = {}
local pub_impl = {}
local pub_struct = {}
local pub_fn = {}
local pub_trait = {}
local pub_enum = {}
local pub_mod_use = {}


for i = 1, #all do
	table.insert(all, "pub " .. all[i])
	table.insert(pub_all, "pub " .. all[i])
end
for i = 1, #impl do
	table.insert(impl, "pub " .. impl[i])
	table.insert(pub_impl, "pub " .. impl[i])
end
for i = 1, #struct do
	table.insert(struct, "pub " .. struct[i])
	table.insert(pub_struct, "pub " .. struct[i])
end
for i = 1, #fn do
	table.insert(fn, "pub " .. fn[i])
	table.insert(pub_fn, "pub " .. fn[i])
end
for i = 1, #trait do
	table.insert(trait, "pub " .. trait[i])
	table.insert(pub_trait, "pub " .. trait[i])
end
for i = 1, #enum do
	table.insert(enum, "pub " .. enum[i])
	table.insert(pub_enum, "pub " .. enum[i])
end
for i = 1, #mod_use do
	table.insert(mod_use, "pub " .. mod_use[i])
	table.insert(pub_mod_use, "pub " .. mod_use[i])
end
local mod_pub = "pub"

local concat_output = function(symbols)
	local strings = {
		search_cmd = "\\v^",
		prefix = "\\s*",
		suffix = "\\s\\zs\\w*",
	}

	local first_str = strings.search_cmd .. strings.prefix
	local final_str = strings.suffix --  .. "<CR>:set nohlsearch<CR>"

	if type(symbols) == "table" then
		local sep = strings.suffix .. "|^" .. strings.prefix
		symbols = table.concat(symbols, sep)
	end

	M.last_search = first_str .. symbols .. final_str
	return M.last_search
end

M.all = {
    both = concat_output(all),
    pub = concat_output(pub_all)
}
M.impl = {
    both = concat_output(impl),
    pub = concat_output(pub_impl),
}
M.struct = {
    both = concat_output(struct),
    pub = concat_output(pub_struct),
}
M.fn = {
    both = concat_output(fn),
    pub = concat_output(pub_fn),
}
M.trait = {
    both = concat_output(trait),
    pub = concat_output(pub_trait),
}
M.enum = {
    both = concat_output(enum),
    pub = concat_output(pub_enum),
}
M.mod_use = {
    both = concat_output(mod_use),
    pub = concat_output(pub_mod_use),
}
M.mod_pub = {
    both = concat_output(mod_pub),
}


return M
