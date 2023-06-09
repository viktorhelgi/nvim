local lspconfig = require("lspconfig")

local cmp = require("cmp")

local cmp_source = function(wanted_kind)
    return {
        config = {
            sources = cmp.config.sources({
                {
                    name = "nvim_lsp",
                    entry_filter = function(entry, _)
                        local label = entry.completion_item.label
                        local received_kind = require("cmp.types").lsp.CompletionItemKind[entry:get_kind()]

                        if wanted_kind == "Property" then
                            if string.sub(label, 0, 1) == "_" then
                                return false
                            end
                            return received_kind == "Variable"
                        end
                        return received_kind == wanted_kind
                    end,
                },
            }),
        },
    }
end

local on_attach = function(client, bufnr)



	local opts = { noremap = true, silent = false }
	local opt = { noremap = true, silent = false, buffer = bufnr }


    vim.keymap.set("n", "<leader>fI", function()
        require('harpoon.tmux').sendCommand('!', "isort "..vim.fn.expand('%').."\r")
        vim.loop.sleep(10)
        vim.cmd('e!')
    end, opt)


	vim.keymap.set("i", "<C-X><C-v>", cmp.mapping.complete(cmp_source("Variable")), opt)
	vim.keymap.set("i", "<C-X><C-p>", cmp.mapping.complete(cmp_source("Property")), opt)
	vim.keymap.set("i", "<C-X><C-m>", cmp.mapping.complete(cmp_source("Module")), opt)
	vim.keymap.set("i", "<C-X><C-s>", cmp.mapping.complete(cmp_source("Class")), opt)
	vim.keymap.set("i", "<C-X><C-f>", cmp.mapping.complete(cmp_source("Function")), opt)

	-- require("lsp_signature").on_attach(require("viktor.config.plugin.lsp_signature"), bufnr) -- no need to specify bufnr if you don't use toggle_key

	vim.cmd("set colorcolumn=88")

	-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opt)
	-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opt)

	-- vim.keymap.set('n', 'gef', vim.diagnostic.open_float, opt)
	-- vim.keymap.set('n', 'geq', vim.diagnostic.setloclist, opt)
	-- vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, opt)
	vim.keymap.set({ "n" }, "gs", function()
		require("lsp_signature").toggle_float_win()
	end, { silent = true, noremap = true, desc = "toggle signature" })

	-- vim.keymap.set({ 'n' }, '<Leader>k', function()
	--     vim.lsp.buf.signature_help()
	-- end, { silent = true, noremap = true, desc = 'toggle signature' })

	-- vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, opt)
	-- vim.keymap.set('n', '<C-g>', require('telescope.builtin').lsp_definitions, opt)
	-- vim.keymap.set('n', 'gt', require('telescope.builtin').lsp_type_definitions, opt)
	-- vim.keymap.set('n', '<C-t>', require('telescope.builtin').lsp_type_definitions, opt)

	-- vim.keymap.set('n', '<leader>lh', vim.lsp.buf.hover, opt)
	-- vim.keymap.set('n', '<leader>lI', vim.lsp.buf.implementation, opt)
	-- vim.keymap.set('n', '<leader>lr', vim.lsp.buf.references, opt)
	-- vim.keymap.set('n', '<leader>ls', vim.lsp.buf.signature_help, opt)
	-- vim.keymap.set('n', '<leader>ld', require('telescope.builtin').lsp_definitions, opt)
	-- vim.keymap.set('n', '<leader>lt', require('telescope.builtin').lsp_type_definitions, opt)
	-- vim.keymap.set('n', '<leader>lf', function() vim.cmd('Format') end, opt)
	-- vim.keymap.set('v', '<leader>lf', "<cmd>Format<cr>", opt)

	require("viktor.config.plugin.neotest").on_attach(client, bufnr)

	vim.keymap.set("n", "<leader>rj", function()
		require('env_init.jupyter').set()
	end, opt)
	vim.keymap.set("n", "<leader>jx", function()
		require('env_init.jupyter').del()
	end, opt)

	vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opt)

	vim.keymap.set("n", "<leader>rl", function()
		local harpoon = require("harpoon.tmux")
		local Path = require("plenary.path")

		local path = Path:new(vim.fn.expand("%"))
		print(path)
		harpoon.sendCommand("!", "cd " .. vim.fn.getcwd() .. " \r " .. "python3 " .. path .. "\r")
	end, opt)
end

local root_dir = lspconfig.util.root_pattern({
    "Pipfile",
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "venv",
    -- 'requirements.txt',
    "requirements.yml",
    "pyrightconfig.json",
    -- ".projections.json",
})


-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

lspconfig.pylyzer.setup({
    -- capabilities = require('cmp_nvim_lsp').default_capabilities(),
	-- cmd = {
	-- 	"/home/viktor/.local/share/nvim/mason/bin/pylsp",
	-- 	"--stdio",
	-- },
	filetypes = { "python", "py" },
	on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        -- vim.pretty_print(client.server_capabilities)
        -- client.server_capabilities.hoverProvider.workDoneProgress = false
    end,
	-- root_dir = root_dir,
	-- settings = {
	-- 	python = {
	-- 		analysis = {
	-- 			useLibraryCodeForTypes = true,
	-- 			autoImportCompletions = true,
	--
	-- 			autoSearchPaths = true,
	-- 			-- typeCheckingMode = "strict", --  ["off", "basic", "strict"]:
	-- 			-- typeCheckingMode = "basic", --  ["off", "basic", "strict"]:
	-- 			typeCheckingMode = "off", --  ["off", "basic", "strict"]:
	-- 			-- diagnosticMode = "workspace", -- ["openFilesOnly", "workspace"]
	-- 			diagnosticMode = "openFilesOnly", -- ["openFilesOnly", "workspace"]
	-- 			diagnosticSeverityOverrides = { -- "error," "warning," "information," "true," "false," or "none"
	-- 				reportDuplicateImport = "warning",
	-- 				reportImportCycles = "warning",
	-- 				reportMissingImports = "error",
	-- 				reportMissingModuleSource = "error",
	-- 			},
	-- 		},
	-- 	},
	-- }
})

-- lspconfig.ruff_lsp.setup({
-- 	root_dir = root_dir,
--     filetypes = { "python" },
-- 	on_attach = function(client, bufnr)
--         -- vim.pretty_print(client.server_capabilities)
--         on_attach(client, bufnr)
--     end,
-- 	init_options = {
-- 		settings = {
-- 			-- Any extra CLI arguments for `ruff` go here.
-- 			args = {},
-- 		},
--         -- interpreter = "python3.8"
-- 	},
-- })
