M = {}

---@param data string
---@param start_line number
---@param end_line number
---@return string|nil
M.get_lines = function(data, start_line, end_line)
	local c = 0
	local counter = 0
	local index = 0
	local start_index = 0
	local end_index = 0

	while true do
		index = data:find("\n", index, false) + 1
		if index == nil then
			return nil
		end

		if counter + 1 == start_line then
			start_index = index
		end

		if counter == end_line then
			end_index = index - 2
			break
		end

		counter = counter + 1

		c = c + 1
		if 10000000 < c then
			print("file is large")
			return nil
		end
	end
	return data:sub(start_index, end_index)
end

---@param data string
---@param start_col number
---@param end_col number
---@param num_lines number
---@return string|nil
M.get_column_range_from_lines = function(data, start_col, end_col, num_lines)
	local c = 0
	local counter = 0
	local index = 0

	local start_index = start_col
	local end_index = 0

	while true do
		index = data:find("\n", index) + 1
		if counter == num_lines - 1 then
			end_index = index + end_col
			break
		end

		counter = counter + 1

		c = c + 1
		if 10000000 < c then
			print("file is large")
			return nil
		end
	end
	return data:sub(start_index + 1, end_index)
end

---@param data string
---@param range Range
---@return string|nil
M.get_selection_range = function(data, range)
	local line_range = M.get_lines(data, range.start.line, range["end"].line)
	if line_range == nil then
		return nil
	end
	-- print("line_range: " .. line_range)

	if range["start"].line == range["end"].line then
		return line_range:sub(range["start"].character + 1, range["end"].character)
	else
		local output = M.get_column_range_from_lines(
			line_range,
			range.start.character,
			range["end"].character,
			range["end"].line - range["start"].line
		)
		if output == nil then
			return nil
		end
		output = output
		return output
	end
end

M._process_derive_impl = function(content)
	return nil
end

--- source: http://lua-users.org/wiki/StringTrim (trim5)
local function trim(s)
	return s:match("^%s*(.*%S)") or ""
end

---@param lines string
---@param text string
---@return string|nil
local function remove_lines_beginning_with(lines, text)
    while true do
        if lines:sub(1,2) == text then
            local index = lines:find("\n")
            if index == nil then
                return nil
            end
            lines = lines:sub(index + 1, -1)
        else
            break
        end
    end
    return lines
end


---@param content string
---@param originSelectionRange string
---@para
M._get_impl_parts = function(content, originSelectionRange)


    local index1 = content:find(" for " .. originSelectionRange)
    if index1 == nil then
        index1 = content:find(" for ")
    end
    return trim(content:sub(1, index1 - 1))


    -- content = remove_lines_beginning_with(content, "#[")
    -- if content == nil then
    --     return nil
    -- end
    --
    -- local index1 = content:find(" for " .. originSelectionRange)
    --
    -- local impl_part = trim(content:sub(1, index1 - 1))
    --
    -- if impl_part:find("<") == nil then
    --     return {}
    -- else
    --     print('---------')
    --     print('---------')
    --     print(content)
    --     print('---------')
    --
    --     local _, index2 = content:find("where", index1 -1)
    --     local where_part = trim(content:sub(index2, 12))
    --     return impl_part, where_part
    -- end
end

---@class GenericType
---@field impl_req string[]

---@class ImplDeclaration
---@field trait string
---@field generics GenericType|nil

---@param content string
---@param originSelectionRange string
---@return ImplDeclaration|nil
M._process_impl_statement = function(content, originSelectionRange)
	content = content:sub(1, content:find("{"))

    local impl_content = remove_lines_beginning_with(content, "#[")
    if impl_content == nil then
        return nil
    end

    local status, impl_part1 = pcall(M._get_impl_parts, impl_content, originSelectionRange)

    if status == false then
        print("Error: \n - Content: \n"..content .. "\n - impl_content: \n"..impl_content)
        return nil
    end

    local generics
	local trait_name
	if impl_part1:find("<") ~= nil then
        local index_start = impl_part1:find("<")
        local index_end = impl_part1:find(">", index_start)
        generics = {impl_part1:sub(index_start, index_end)}
		trait_name = impl_part1:sub(index_end + 2, -1)
	else
		trait_name = impl_part1:gsub("impl ", "")
	end

    ---@type ImplDeclaration
	local output = {
        trait = trait_name,
        generics = generics
    }
    return output
end

---@class UnknownImplStatement
---@field targetRange string|nil
---@field targetSelectionRange string|nil

---@class StandardImplStatement
---@field targetImplStatement ImplDeclaration|nil
---@field targetRange string|nil
---@field targetSelectionRange string|nil

---@class DeriveImplStatement
---@field Implementations string[]

---@enum ImplType
M.IMPL_TYPE = {
    derive = 0,
    standard = 1,
    unknown = 2,
}

---@class ImplStatement
---@field impl_type ImplType
---@field content StandardImplStatement|DeriveImplStatement|UnknownImplStatement

---@param item ImplItem
---@param content string
---@param originSelectionRange string
---@return ImplStatement|nil
M.process_inputs = function(item, content, originSelectionRange)
	local lines = M.get_lines(content, item.targetSelectionRange.start.line, item.targetSelectionRange["end"].line)

	if lines == nil then
		return nil
	end

	print(lines:sub(0, 8))

	if lines:sub(0, 8) == "#[derive" then

		---@type ImplStatement
		local outp = {
            impl_type = M.IMPL_TYPE.derive,
            content = {"Copy", "Clone", "Display" }
        }

		return outp
	else
		local whole_impl_block = M.get_lines(content, item.targetRange.start.line, item.targetRange["end"].line)
		local type_being_implemented = M.get_selection_range(content, item.targetSelectionRange)
        if type_being_implemented ~= nil then
            type_being_implemented = type_being_implemented:gsub(" ", ""):gsub("\n", ""):gsub(",", ", ")
        end

        local impl_statement
        if whole_impl_block ~= nil then
            impl_statement = M._process_impl_statement(whole_impl_block, originSelectionRange)
        end

        if impl_statement == nil then
            ---@type ImplStatement
            local outp = {
                impl_type = M.IMPL_TYPE.unknown,
                content = {
                    targetRange = whole_impl_block,
                    targetSelectionRange = type_being_implemented,
                }
            }
            return outp
        else
            ---@type ImplStatement
            local outp = {
                impl_type = M.IMPL_TYPE.standard,
                content = {
                    targetImplStatement = impl_statement,
                    targetRange = whole_impl_block,
                    targetSelectionRange = type_being_implemented,
                }
            }
            return outp
        end
	end
end

return M
