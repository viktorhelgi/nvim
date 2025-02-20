local rust_tools = require('rust-tools')

local my_on_attach = function(_, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	require('lsp_signature').on_attach(require('viktor.config.plugin.lsp_signature_configs'), bufnr)
end

local function _get_capabilites()
	local out = require('cmp_nvim_lsp').default_capabilities()
	out.textDocument.completion.completionItem.snippetSupport = false
	return out
end

rust_tools.setup({
	tools = {
		-- executor = require("rust-tools.executors").toggleterm,
		executor = require('rust_funcs').run.rust_tools_executor2,
		inlay_hints = {
			-- automatically set inlay hints (type hints)
			-- default: true
			auto = true,
			only_current_line = true,
			highlight = 'TelescopePreviewTitle',
		},
	},
	server = {
		capabilities = _get_capabilites(),
		on_attach = my_on_attach,
		-- settings = {
		-- 	['rust-analyzer'] = {
		-- 		cargo = {
		-- 			autoReload = true,
		-- 			features = {
		-- 				'dev',
		-- 			},
		-- 		},
		-- 		procMacro = {
		-- 			enable = false,
		-- 		},
		-- 		diagnostics = {
		-- 			enable = false,
		-- 			disabled = { 'unresolved-proc-macro' },
		-- 		},
		-- 		check = {
		-- 			command = 'clippy',
		-- 			-- extraArgs = { },
		-- 		},
		-- 		checkOnSave = {
		-- 			command = 'clippy',
		-- 		},
		-- 	},
		-- },
		filetypes = { 'rust', 'rs' },
		checkOnSave = {
			enable = true,
		},
		-- cmd = { '/home/viktorhg/git-repos/ra-multiplex/target/release/ra-multiplex', 'client' },
		cmd = {"rust-analyzer"},
		handlers = {
			-- vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
			-- vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })
			['textDocument/hover'] = require('vim.lsp').with(vim.lsp.handlers.hover, {
				-- border = "single",
				border = 'rounded',
				width = 80,
			}),
			['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
				-- delay update diagnostics
				update_in_insert = false,
			}),
			-- ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
		},
	},
})

rust_tools.inlay_hints.set()
rust_tools.inlay_hints.unset()
rust_tools.inlay_hints.enable()
rust_tools.inlay_hints.disable()
-- /home/viktor/repos/ex/rust_warp_api
-- vim.keymap.set("n", "<leader>rT", function()
-- 	vim.cmd("TSTextobjectGotoPreviousStart @function.outer")
-- 	vim.cmd("normal t(")
-- 	vim.cmd("RustHoverActions")
-- 	vim.cmd("RustHoverActions")
-- 	-- require'rust-tools'.hover_actions.hover_actions()
-- 	-- require'rust-tools'.hover_actions.hover_actions()
-- end)

-- bin/http_server.rs
-- src/pathfinding/evaluate.rs
-- src/pathfinding/run.rs
-- src/pathfinding/astar/execute.rs
-- src/pathfinding/astar/evaluator/mod.rs
-- src/geos/raster/base_3dim.rs
-- src/data_manager/forecast/grib_data.rs
-- src/read/grib/mod.rs
-- src/geos/raster/aliases.rs
-- src/geos/raster/join.rs
-- src/geos/raster/owned.rs

-- vim.diagnostic.handlers["my/notify"] = {
--   show = function(namespace, _, diagnostics, opts)
--     -- In our example, the opts table has a "log_level" option
--     local level = opts["my/notify"].log_level
--
--     local name = vim.diagnostic.get_namespace(namespace).name
--     local msg = string.format("%d diagnostics in buffer %d from %s",
--                               #diagnostics,
--                               bufnr,
--                               name)
--     vim.notify(msg, level)
--   end,
-- }
--
-- -- Users can configure the handler
-- vim.diagnostic.config({
--   ["my/notify"] = {
--     log_level = vim.log.levels.INFO
--   }
-- })
