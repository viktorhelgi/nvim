
local _on_attach = function(_, _)
	-- require("viktor.config.plugin.neotest").on_attach(client, bufnr)

	-- vim.keymap.set("n", "<leader>rj", function()
	-- 	require("env_init.jupyter").set()
	-- end, opt)
	-- vim.keymap.set("n", "<leader>jx", function()
	-- 	require("env_init.jupyter").del()
	-- end, opt)
	-- vim.keymap.set("n", "<leader>rl", function()
	-- 	local harpoon = require("harpoon.tmux")
	-- 	local Path = require("plenary.path")
	--
	-- 	local path = Path:new(vim.fn.expand("%"))
	-- 	print(path)
	-- 	harpoon.sendCommand("!", "cd " .. vim.fn.getcwd() .. " \r " .. "python3 " .. path .. "\r")
	-- end, opt)
end

require('lspconfig').pylyzer.setup({
	filetypes = { 'python', 'py' },
})
