local lspconfig = require("lspconfig")
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
    for i = new_index, size_orig do arr[i] = nil end
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


local on_attach = function(client, bufnr)
    -- if client.name == "pyright" then
    --     vim.keymap.set('n', '<Leader>o', '<CMD>PyrightOrganizeImports<CR>')
    --     vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    --         custom_on_publish_diagnostics, {})
    --
    -- end

	local opts = { noremap = true, silent = false }
	local opt = { noremap = true, silent = false, buffer = bufnr }

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opt)
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

	-- require("viktor.config.plugin.neotest").on_attach(client, bufnr)

	-- vim.keymap.set("n", "<leader>rj", function()
	-- 	require('env_init.jupyter').set()
	-- end, opt)
	-- vim.keymap.set("n", "<leader>jx", function()
	-- 	require('env_init.jupyter').del()
	-- end, opt)

	-- vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opt)

	-- vim.keymap.set("n", "<leader>rl", function()
	-- 	local harpoon = require("harpoon.tmux")
	-- 	local Path = require("plenary.path")
	--
	-- 	local path = Path:new(vim.fn.expand("%"))
	-- 	print(path)
	-- 	harpoon.sendCommand("!", "cd " .. vim.fn.getcwd() .. " \r " .. "python3 " .. path .. "\r")
	-- end, opt)
end

local root_dir = lspconfig.util.root_pattern({
	"Pipfile",
	"pyproject.toml",
	"setup.py",
	"setup.cfg",
	"venv",
	"requirements.yml",
	"pyrightconfig.json",
	".letsgo",
})

local util = require("lspconfig.util")
local path = util.path

local function get_python_path(workspace)
	-- Use activated virtualenv.
	if vim.env.VIRTUAL_ENV then
		return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
	end

	-- Find and use virtualenv in workspace directory.
	for _, pattern in ipairs({ "*", ".*" }) do
		local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
		if match ~= "" then
			return path.join(path.dirname(match), "bin", "python")
		end
	end

	-- Fallback to system Python.
	return "python3"
end

lspconfig.pyright.setup({
	-- before_init = function(_, config)
	--     config.settings.python.pythonPath = get_python_path(config.root_dir)
	-- end,
	cmd = {
		-- "/home/viktor/.local/share/nvim/mason/bin/pyright-langserver",
		"/usr/bin/pyright-langserver",
		"--stdio",
	},
	filetypes = { "python", "py" },
	on_attach = function(client, bufnr)
		client.server_capabilities = require("viktor.lsp.capabilities.pyright")
		on_attach(client, bufnr)
	end,
	root_dir = root_dir,
	-- capabilities = (function()
	-- 	local capabilities = vim.lsp.protocol.make_client_capabilities()
	--
	-- 	capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
	--
	-- 	return capabilities
	-- end)(),
	settings = {
		pyright = {
			-- disableLanguageServices = true,
			disableOrganizeImports = true,
			-- reportMissingModuleSource = "none",
			-- reportMissingImports = "none",
			reportUndefinedVariable = "none",

			disableLanguageServices = false,

			-- reportMissingImports = "none",
			-- reportUnusedVariable = "none",
			-- reportUnusedClass = "none",
			--
			--          reportUnknownMemberType = "none",
			--          reportUnknownParameterType = "none",
			--          reportUnknownVariableType = "none",
			--          reportUnnecessaryCast = "none",
			--          reportUnnecessaryComparison = "none",
			--          reportUnnecessaryContains = "none",
			--          reportUnnecessaryIsInstance = "none",
			--          -- reportUnusedClass = "none",
			--          reportUnusedImport = "none",
			--          reportUnusedFunction = "none",
			--          -- reportUnusedVariable = "none",
			--          reportUntypedBaseClass = "none",
			--          reportUntypedClassDecorator = "none",
			--          reportUntypedFunctionDecorator = "none",
			--          reportUntypedNamedTuple = "none",
			--          reportCallInDefaultInitializer = "none",
			--          reportImplicitOverride = "none",
			--          reportImplicitStringConcatenation = "none",
			--          reportImportCycles = "none",
			--          reportMissingSuperCall = "none",
			--          reportPropertyTypeMismatch = "none",
			--          reportShadowedImports = "none",
			--          reportUninitializedInstanceVariable = "none",
			--          reportUnnecessaryTypeIgnoreComment = "none",
			--          reportUnusedCallResult = "none",

			reportMissingImports = false,
			reportUnusedVariable = false,
			reportUnusedClass = false,
			reportMissingModuleSource = false,

			pythonVersion = "3.9",
		},
		python = {
			analysis = {
				-- useLibraryCodeForTypes = false,
				-- autoImportCompletions = true,
				autoSearchPaths = true,
				-- typeshedPaths = {"/home/viktor/hm/rust-main/fetch-data/stubs"},
				-- typeCheckingMode = "strict", --  ["off", "basic", "strict"]:
				-- typeCheckingMode = "basic", --  ["off", "basic", "strict"]:
				typeCheckingMode = "basic", --  ["off", "basic", "strict"]:
                -- diagnosticSeverityOverrides = {
                --     reportMissingImports = "none",
                --     reportUnusedVariable = "none",
                --     reportUnusedClass = "none",
                --     reportMissingModuleSource = "none",
                --     -- reportMissingImports = "none",
                --     reportUndefinedVariable = "none",
                -- },

				-- stubPath = "/home/viktor/hm/rust-main/fetch-data/stubs",
				-- diagnosticMode = "workspace", -- ["openFilesOnly", "workspace"]
				-- diagnosticMode = "openFilesOnly", -- ["openFilesOnly", "workspace"]
				-- diagnosticSeverityOverrides = { -- "error," "warning," "information," "true," "false," or "none"
				-- 	reportDuplicateImport = "warning",
				-- 	reportImportCycles = "warning",
				-- 	reportMissingImports = "error",
				-- 	reportMissingModuleSource = "error",
				-- },
			},
		},
	},
	-- handlers = {
	-- 	["textDocument/publishDiagnostics"] = function() end,
	-- },
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
