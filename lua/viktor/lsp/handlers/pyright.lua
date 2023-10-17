local function filter(arr, func)
	-- Filter in place
	-- https://stackoverflow.com/questions/49709998/how-to-filter-a-lua-array-inplace
	local new_index = 1
	local size_orig = #arr
	for old_index, v in ipairs(arr) do
		if func(v, old_index) then
			arr[new_index] = v
			new_index = new_index + 1
		end
	end
	for i = new_index, size_orig do
		arr[i] = nil
	end
end

local function pyright_accessed_filter(diagnostic)
	-- Allow kwargs to be unused, sometimes you want many functions to take the
	-- same arguments but you don't use all the arguments in all the functions,
	-- so kwargs is used to suck up all the extras
	-- if diagnostic.message == '"kwargs" is not accessed' then
	-- 	return false
	-- end
	--
	-- Allow variables starting with an underscore
	-- if string.match(diagnostic.message, '"_.+" is not accessed') then
	-- 	return false
	-- end

	-- For all messages "is not accessed"
	if string.match(diagnostic.message, '".+" is not accessed') then
		return false
	end

	return true
end

local function custom_on_publish_diagnostics(a, params, client_id, c, config)
	filter(params.diagnostics, pyright_accessed_filter)
	vim.lsp.diagnostic.on_publish_diagnostics(a, params, client_id, c, config)
end

return {
	textDocument = {
		publishDiagnostics = custom_on_publish_diagnostics,
		documentHighlight = nil,
		documentSymbol = nil,
		signatureHelp = nil,
		references = nil,
		definition = nil,
		completion = nil,
		codeAction = nil,
		rename = nil,
		hover = nil,
		-- -- probably not implemented
		-- declaration*
		-- formatting
		-- implementation*
		-- publishDiagnostics
		-- rangeFormatting
		-- typeDefinition*
	},
	callHierarchy = {
		incomingCalls = nil,
		outgoingCalls = nil,
	},
	-- window = {
	-- 	logMessage = nil,
	-- 	showMessage = nil,
	-- 	showDocument = nil,
	-- 	showMessageRequest = nil,
	-- },
	workspace = {
		symbol = nil,
		-- applyEdit = nil,
	},
	document = {
		Highlight = nil,
		Symbol = nil,
	},
}
