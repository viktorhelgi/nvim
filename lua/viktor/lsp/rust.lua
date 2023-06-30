local rust_tools = require("rust-tools")
local rust_funcs = require("rust_funcs")

local function _cmd(input)
	return "<CMD>" .. input .. "<CR>"
end

local my_on_attach = function(client, bufnr)
	pcall(function()
		vim.keymap.del("i", "<tab>")
	end)
	pcall(function()
		vim.keymap.del("n", "caÞ")
	end)
	vim.o.foldmethod = "marker"
	vim.cmd("set colorcolumn=102")
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	require("lsp_signature").on_attach(require("viktor.config.plugin.lsp_signature"), bufnr) -- no need to specify bufnr if you don't use toggle_key

	require("viktor.config.plugin.neotest").on_attach(client, bufnr)
	require("viktor.config.plugin.tasks").on_attach(client, bufnr)

	require("which-key").register({
		["["] = {
			d = { vim.diagnostic.goto_prev, "diagnostic" },
		},
		["]"] = {
			d = { vim.diagnostic.goto_next, "diagnostic" },
		},
		["'"] = {
			name = "goto",
			L = { "<CMD>e ~/.config/nvim/lua/viktor/lsp/rust.lua<CR>", "lsp" },
			C = { "<CMD>e ~/.config/nvim/after/plugin/cmp/rust.lua<CR>", "cmp" },
		},
		g = {
			name = "goto",
			c = { _cmd("RustOpenCargo"), "cargo" },
			i = { vim.lsp.buf.implementation, "impl" },
			D = { vim.lsp.buf.declaration, "decl" },
			k = { _cmd("RustHoverActions"), "hover-action" },
			-- k = {"gk", "K" },
			p = { _cmd("RustParentModule"), "parent" },
			r = { vim.lsp.buf.references, "ref" },
			s = { vim.lsp.buf.signature_help, "sign" },
		},
		-- l = {
		-- 	a = { _cmd("CodeActionMenu"), "code-action" },
		-- 	r = { vim.lsp.buf.rename, "rename" },
		-- },
		c = {
			name = "Change/Cargo",
			-- a = { _cmd("RustCodeAction"), "code-action" },
			b = { _cmd("Task start cargo build"), "build" },
			d = { vim.diagnostic.setqflist, "setqflist" },
			r = { rust_funcs.run.with_arguments, "run --" },
			l = { rust_funcs.run.last_cmd, "run --" },
			s = { _cmd("DiagWindowShow"), "show diagnostic" },
			R = { rust_funcs.run.selected_binary, "run --bin <?>" },
			q = { _cmd("cclose"), "close qflist" },
		},
		["<leader>r"] = {
			name = "Rust",

			-- e = { _cmd("RustEmitAsm") },
			-- ei = { _cmd("RustEmitIr") },
			-- ee = { _cmd("RustExpand") },
			-- F = { _cmd("RustFmtRange") },
			-- i = {_cmd("RustSetInlayHints")},
			-- i = {_cmd("RustToggleInlayHints")},
			-- hr = {_cmd("RustHoverRange")},
			-- j = {_cmd("RustJoinLines")},
			-- oc = {_cmd("e Cargo.toml")},
			-- oe = {_cmd("RustOpenExternalDocs")},
			-- P = {_cmd("RustPlay")},
			-- rr = { _cmd("RustRun") },
			-- rR = { _cmd("RustRunnables") },
			-- C = {_cmd("RustViewCrateGraph")},
			-- p = {_cmd("RustParentModule")},
			b = {
				function()
					vim.cmd("copen")
					vim.cmd("wincmd w")
					vim.cmd("silent make build")
				end,
				"build with copen",
			},
			i = { require("rust_funcs").toggle_inlay_hints, "toggle inlay hints" },
			C = { _cmd("RustOpenCargo") },
			c = {
				function()
					vim.cmd("Task start cargo clippy --tests --examples")
				end,
				"clippy tests examples",
			},
			f = { _cmd("RustFmt") },
			h = { _cmd("RustHoverActions") },
			l = { rust_funcs.run.something_good, "something good" },
			p = { require("rust_funcs").cargo_run, "cargo run" },
			m = {
				function()
					require("harpoon.tmux").sendCommand(
						"!",
						'maturin develop --cargo-extra-args="--features python-bindings"\r' .. "python3 main.py\r"
					)
				end,
				"maturin build",
			},
			r = { _cmd("CargoReload") },
			-- r = {
			-- 	w = { _cmd("RustReloadWorkspace") },
			-- },
			-- t = {
			-- 	function()
			-- 		vim.cmd("copen")
			-- 		vim.cmd("wincmd w")
			-- 		vim.cmd("silent make test " .. vim.fn.expand("%"))
			-- 	end,
			-- 	"make test file",
			-- },
			t = {
				-- function()
				--     vim.cmd("Task start cargo test")
				-- end
				function()
					vim.cmd("TSTextobjectGotoPreviousStart @function.outer")
					vim.cmd("normal t(")
					vim.cmd("RustHoverActions")
					vim.cmd("RustHoverActions")
					-- require'rust-tools'.hover_actions.hover_actions()
					-- require'rust-tools'.hover_actions.hover_actions()
				end,
				"cargo test",
			},
			-- T = { rust_funcs.tree.show, "module tree" },
			T = { rust_funcs.tree.bin, "module tree" },
			-- T = { rust_funcs.tree.lib, "module tree" },
		},
	})

	rust_funcs.jump.on_attach(client, bufnr)

	vim.cmd("compiler cargo")
end

local function _get_capabilites()
	-- local out = vim.lsp.protocol.make_client_capabilities()
	-- out = require('cmp_nvim_lsp').update_capabilities(capabilities)
	local out = require("cmp_nvim_lsp").default_capabilities()
	out.textDocument.completion.completionItem.snippetSupport = false
	return out
end

rust_tools.setup({
	tools = {
		inlay_hints = {
			-- automatically set inlay hints (type hints)
			-- default: true
			auto = true,
			only_current_line = true,
			highlight = "TelescopePreviewTitle",
		},
	},
	server = {
		capabilities = _get_capabilites(),
		on_attach = my_on_attach,
		settings = {
			["rust-analyzer"] = {
				cargo = {
					autoReload = true,
					-- features = {
					-- 	"all",
					-- 	"gcloud_bucket",
					-- 	-- "read_tiff",
					-- 	-- "bathymetry",
					-- 	-- "forecast",
					-- 	-- "server",
					-- 	-- "examples"
					-- 	-- "gcloud_bucket",
					-- 	-- "read-tiff",
					-- 	-- "bathymetry",
					-- 	-- "pathfinding",
					-- 	-- "write",
					-- 	-- "python-bindings",
					-- },
				},
				-- interpret = {
				--     tests = true
				-- },

				-- procMacro = {
				-- 	enable = false,
				-- },
				diagnostics = {
					enable = true,
					disabled = { "unresolved-proc-macro" },
				},
				check = {
					command = "clippy",
					extraArgs = {
						"--tests",
						-- "--example temp",
						-- "--features=all",
					},
				},
				checkOnSave = {
					command = "clippy",
				},
			},
		},
		filetypes = { "rust", "rs" },
		checkOnSave = {
			enable = true,
		},
		server = {
			cmd = "rust-analyzer",
			-- cmd = "nice --10 rust-analyzer",
		},
		handlers = {
			-- vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
			-- vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })
			["textDocument/hover"] = require("vim.lsp").with(vim.lsp.handlers.hover, {
				-- border = "single",
				border = "rounded",
				width = 80,
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
