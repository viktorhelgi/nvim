local rust_tools = require('rust-tools')

local my_on_attach = function(_, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	require('lsp_signature').on_attach(require('viktor.config.plugin.lsp_signature_configs'), bufnr)
	-- vim.lsp.inlay_hints.enable(false)
end

local function _get_capabilites()
	local out = require('cmp_nvim_lsp').default_capabilities()
	out.textDocument.completion.completionItem.snippetSupport = false
	return out
end

vim.g.rustaceanvim = {
	-- Plugin configuration
	tools = {
		-- executor = require("rust-tools.executors").toggleterm,
		executor = require('rust_funcs').run.rust_tools_executor2,
		inlay_hints = {
			-- automatically set inlay hints (type hints)
			-- default: true
			auto = false,
			only_current_line = true,
			highlight = 'TelescopePreviewTitle',
		},
	},
	-- LSP configuration
	server = {
		on_attach = my_on_attach,
		-- default_settings = {
		default_settings = {
			['rust-analyzer'] = {
				-- cargo = {
				-- 	features = { 'jitter' },
				-- 	allFeatures = false, -- or true to enable every feature
				-- 	noDefaultFeatures = false, -- set true if you want to drop default features
				-- },

				-- Inlay hints
				inlayHints = {
					bindingModeHints = { enable = false },
					chainingHints = { enable = false },
					closingBraceHints = { enable = false, minLines = 25 },
					closureCaptureHints = { enable = false },
					closureReturnTypeHints = { enable = 'never' },
					closureStyle = 'impl_fn',
					discriminantHints = { enable = 'never' },
					expressionAdjustmentHints = {
						enable = 'never',
						hideOutsideUnsafe = false,
						disableReborrows = false,
						mode = 'prefix',
					},
					genericParameterHints = {
						const = { enable = false },
						lifetime = { enable = false },
						type = { enable = false },
					},
					implicitDrops = { enable = false },
					implicitSizedBoundHints = { enable = false },
					lifetimeElisionHints = { enable = 'never', useParameterNames = false },
					maxLength = 25,
					parameterHints = { enable = false },
					rangeExclusiveHints = { enable = false },
					reborrowHints = { enable = 'never' },
					renderColons = false,
					typeHints = {
						enable = false,
						hideClosureInitialization = false,
						hideClosureParameter = false,
						hideNamedConstructor = false,
					},
				},

				-- -- Semantic highlighting
				-- semanticHighlighting = {
				-- 	comments = { enable = true },
				-- 	['doc.comment.inject'] = { enable = true },
				-- 	nonStandardTokens = true,
				-- 	operator = { enable = true, specialization = { enable = false } },
				-- },
				--
				-- -- Runnables
				-- runnables = {
				-- 	-- command = nil,
				-- 	extraArgs = {},
				-- 	extraTestBinaryArgs = { '--show-output' },
				-- },
				--
				-- -- Formatting
				-- rustfmt = {
				-- 	extraArgs = {},
				-- 	-- overrideCommand = nil,   -- array form if set
				-- 	rangeFormatting = { enable = false },
				-- },
				--
				-- -- Misc
				-- notifications = { cargoTomlNotFound = true },
				-- lru = { -- NOTE: numbers left unset use internal defaults
				-- 	-- capacity = nil,         -- defaults to 128
				-- 	['query.capacities'] = {},
				-- },
				-- -- numThreads = nil,         -- auto
				-- cfg = { setTest = true },
				-- document = { symbol = { search = { excludeLocals = true } } },
				-- -- rustc = { source = nil },
			},
		},
		--
		-- 	-- rust-analyzer language server configuration
		-- 	-- ['rust-analyzer'] = {
		-- 	--              cargo = {
		-- 	--                  features = {'env-file'},
		-- 	--                  -- features = 'all',
		-- 	--                  -- features = {'all'},
		-- 	--              },
		-- 	--              features = {'env-file'},
		-- 	--              autoReload = true,
		-- 	-- },
		-- },
	},
	-- DAP configuration
	dap = {},
}

-- let g:rustaceanvim = {
-- \  'server': {
-- \    'settings': {
-- \      'rust-analyzer': {
-- \        'cargo': {
-- \          'features': ['my-feature1', 'my-feature2'],
-- \        },
-- \      },
-- \    },
-- \  },
-- \}

-- rust_tools.setup({
CONFIG = {
	tools = {
		-- executor = require("rust-tools.executors").toggleterm,
		executor = require('rust_funcs').run.rust_tools_executor2,
		inlay_hints = {
			-- automatically set inlay hints (type hints)
			-- default: true
			auto = false,
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
		cmd = { '/home/viktorhg/git-repos/ra-multiplex/target/release/ra-multiplex', 'client' },
		-- cmd = { 'rust-analyzer' },
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
}

-- rust_tools.inlay_hints.set()
-- rust_tools.inlay_hints.unset()
-- rust_tools.inlay_hints.enable()
-- rust_tools.inlay_hints.disable()

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
--
--
-- defaults
--
-- Cargo
-- cargo = {
-- 	allTargets = true,
-- 	autoreload = true,
-- 	buildScripts = {
-- 		enable = true,
-- 		invocationStrategy = 'per_workspace',
-- 		rebuildOnSave = true,
-- 		useRustcWrapper = true,
-- 		-- overrideCommand = nil,
-- 	},
-- 	cfgs = { 'debug_assertions', 'miri' },
-- 	extraArgs = {},
-- 	extraEnv = {},
-- features = {
--                    "atomic"
--                }, -- "all" to enable all features
-- 	noDefaultFeatures = false,
-- 	noDeps = false,
-- 	sysroot = 'discover',
-- 	-- sysrootSrc = nil,
-- 	-- target = nil,
-- 	-- targetDir = nil,          -- true or a path
-- },
--
-- -- Checks / diagnostics-on-save
-- checkOnSave = true,
-- check = {
-- 	-- allTargets = nil,        -- defaults to cargo.allTargets
-- 	command = 'check',
-- 	extraArgs = {},
-- 	extraEnv = {},
-- 	-- features = nil,          -- defaults to cargo.features ("all" allowed)
-- 	ignore = {},
-- 	invocationStrategy = 'per_workspace',
-- 	-- noDefaultFeatures = nil, -- defaults to cargo.noDefaultFeatures
-- 	-- overrideCommand = nil,
-- 	-- targets = nil,
-- 	workspace = true,
-- },
--
-- -- Diagnostics
-- diagnostics = {
-- 	enable = true,
-- 	disabled = {},
-- 	experimental = { enable = false },
-- 	remapPrefix = {},
-- 	styleLints = { enable = false },
-- 	warningsAsHint = {},
-- 	warningsAsInfo = {},
-- },
--
-- -- Proc-macros
-- procMacro = {
-- 	enable = true,
-- 	attributes = { enable = true },
-- 	ignored = {},
-- 	-- server = nil,
-- },
--
-- -- Files
-- files = {
-- 	exclude = {},
-- 	watcher = 'client',
-- },
--
-- -- Imports
-- imports = {
-- 	prefixExternPrelude = false,
-- },
--
-- -- Completion
-- completion = {
-- 	addSemicolonToUnit = true,
-- 	autoAwait = { enable = true },
-- 	autoIter = { enable = true },
-- 	autoimport = {
-- 		enable = true,
-- 		exclude = {
-- 			{ path = 'core::borrow::Borrow', type = 'methods' },
-- 			{ path = 'core::borrow::BorrowMut', type = 'methods' },
-- 		},
-- 	},
-- 	autoself = { enable = true },
-- 	callable = { snippets = 'fill_arguments' },
-- 	excludeTraits = {},
-- 	fullFunctionSignatures = { enable = false },
-- 	hideDeprecated = false,
-- 	-- limit = nil,
-- 	termSearch = { enable = false, fuel = 1000 },
-- },
-- }
