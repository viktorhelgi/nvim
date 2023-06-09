local lspconfig = require("lspconfig")

local on_attach = function(client, bufnr)
	-- require("lint").linters_by_ft = {
	-- 	python = { "ruff" },
	-- }

	local opts = { noremap = true, silent = false }
	local opt = { noremap = true, silent = false, buffer = bufnr }
	--
	--    vim.keymap.set('n', '<space>lF', function() vim.lsp.buf.format { async = true } end, opt)
	--
	-- require("viktor.config.plugin.neotest").on_attach(client, bufnr)
	--
	-- vim.keymap.set("n", "<leader>rj", function()
	-- 	require('env_init.jupyter').set()
	-- end, opt)
	-- vim.keymap.set("n", "<leader>jx", function()
	-- 	require('env_init.jupyter').del()
	-- end, opt)
	--
	-- vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opt)
	--
	-- vim.keymap.set("n", "<leader>rl", function()
	-- 	local harpoon = require("harpoon.tmux")
	-- 	local Path = require("plenary.path")
	--
	-- 	local path = Path:new(vim.fn.expand("%"))
	-- 	print(path)
	-- 	harpoon.sendCommand("!", "cd " .. vim.fn.getcwd() .. " \r " .. "python3 " .. path .. "\r")
	-- end, opt)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }


	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<space>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
end

-- local root_dir = lspconfig.util.root_pattern({
-- 	"Pipfile",
-- 	"pyproject.toml",
-- 	"setup.py",
-- 	"setup.cfg",
-- 	"venv",
-- 	-- 'requirements.txt',
-- 	"requirements.yml",
-- 	"pyrightconfig.json",
-- 	-- ".projections.json",
-- })

local configs = require("lspconfig.configs")
if not configs.ruff_lsp then
	configs.ruff_lsp = {
		default_config = {
			cmd = { "ruff-lsp" },
			filetypes = { "python" },
			root_dir = require("lspconfig").util.find_git_ancestor,
			init_options = {
				settings = {
					args = {},
				},
			},
		},
	}
end

local root_dir = lspconfig.util.root_pattern({
	"ruff.toml",
	".ruff.toml",
    "pyproject.toml"
})
lspconfig.ruff_lsp.setup({
	root_dir = root_dir,
	-- filetypes = { "python" },
	on_attach = function(client, bufnr)
        -- vim.pretty_print(client.server_capabilities)
        -- client.server_capabilities.hoverProvider = false
        on_attach(client, bufnr)
    end,


	-- init_options = {
	-- 	settings = {
	-- -- 		-- Any extra CLI arguments for `ruff` go here.
	-- 		args = {
 --                -- config = "/home/viktor/hm/backend/REjk",
 --                -- config = root_dir() .. "/ruff.toml"
 --            },
	-- -- 		path = "/home/viktor/.local/share/nvim/mason/bin/ruff",
	-- 	},
	-- -- 	-- interpreter = "python3.8"
	-- },
})
