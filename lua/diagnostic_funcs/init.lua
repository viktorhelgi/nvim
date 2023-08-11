local M = {
	enabled = true,
}

M.toggle = function()
	if M.enabled then
		vim.diagnostic.disable(0)
		M.enabled = false
	else
		vim.diagnostic.enable(0)
		M.enabled = true
	end
end

---@param severity DiagnosticSeverity|nil
M.loclist = function(severity)
	if severity == nil then
		vim.diagnostic.setloclist()
	else
		vim.diagnostic.setloclist({ severity = severity })
	end
	require("keys").register_jump_mappings("loclist")
end

---@param severity DiagnosticSeverity|nil
M.qflist = function(severity)
	if severity == nil then
		vim.diagnostic.setqflist()
	else
		vim.diagnostic.setqflist({ severity = severity })
	end
	require("keys").register_jump_mappings("qf")
end


return M
