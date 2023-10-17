local rust_tools = require("rust-tools")

local rust_funcs = require("rust_funcs")
local neotest = require("neotest")

local function _cmd(input)
	return "<CMD>" .. input .. "<CR>"
end

local build_settings = "--release --features dev"

local my_on_attach = function(client, bufnr)

    -- local ns_id = vim.api.nvim_create_namespace("cwd-namespace")

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

	-- require("viktor.config.plugin.neotest").on_attach(client, bufnr)
	require("viktor.config.plugin.tasks").on_attach(client, bufnr)

    local ctrl = function(key)
        return "<C-"..key..">"
    end

	require("which-key").register({
		["["] = {
            t = { function() neotest.jump.prev({status='failed'}) end, "test"}
		},
		["]"] = {
            t = { function() neotest.jump.next({status='failed'}) end, "test"}
		},
		["'"] = {
			name = "goto",
			L = { "<CMD>e ~/.config/nvim/lua/viktor/lsp/rust.lua<CR>", "lsp" },
			C = { "<CMD>e ~/.config/nvim/after/plugin/cmp/rust.lua<CR>", "cmp" },
            o = {
                function()
                    neotest.output.open({ enter = true, last_run = true, auto_close = false })
                end,
                "neotest-open",
            },
            l = {
                function()
                    neotest.output.open({
                        enter = true,
                        last_run = true,
                        auto_close = false,
                        open_win = function()
                            vim.cmd('split')
                            return vim.api.nvim_get_current_win()
                        end
                    })
                end,
                "neotest-open-left"
            },
            d = { neotest.output_panel.toggle, "neotest-open-down" }

		},


		g = {
			name = "goto",
			c = { _cmd("RustOpenCargo"), "cargo" },
			h = { _cmd("RustHoverActions"), "hover-action" },
			p = { _cmd("RustParentModule"), "parent" },
		},
		-- l = {
		-- 	a = { _cmd("CodeActionMenu"), "code-action" },
		-- 	r = { vim.lsp.buf.rename, "rename" },
		-- },
		c = {
			name = "Change/Cargo",
			b = { _cmd("Task start cargo build "..build_settings), "build" },
			["*"] = { _cmd("Task start cargo clippy "..build_settings), "build" },
			["|"] = { _cmd("Task start cargo bench "..build_settings), "build" },
			r = { rust_funcs.run.with_arguments, "run --" },
			l = { rust_funcs.run.last_cmd, "run --" },
			R = { rust_funcs.run.selected_binary, "run --bin <?>" },
		},
        ["<leader>c"] = {
			["*"] = { _cmd("Task start cargo clippy "..build_settings), "build" },
        },
		d = {
			s = { rust_funcs.explain_error.open_popup_here, "explain error" },
			J = { rust_funcs.explain_error.print_error_as_json, "print error as json" },
		},
		["<leader>d"] = {
			e = {
				function()
					vim.ui.input({ prompt = "Error Code: " }, function(e)
						rust_funcs.explain_error.open_popup(e)
					end)
				end,
				"explain error",
			},
		},
        ["<leader>"] = {
            n = {
                name = "Run",
                a = {
                    function()
                        neotest.run.run(vim.fn.getcwd().."/src")
                    end,
                    "all tests",
                },
                f = {
                    function()
                        neotest.run.run(vim.fn.expand('%'))
                    end,
                    "all tests",
                },
                h = {
                    function()
                        neotest.run.run({extra_args = { "--success-output=immediate" }})
                    end,
                    "this test",
                },
                l = { neotest.run.run_last , "last test"},
                m = { neotest.summary.run_marked, "marked tests"},
                s = { neotest.summary.toggle, "open summary"}
            },
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
			-- b = {
			-- 	function()
			-- 		vim.cmd("copen")
			-- 		vim.cmd("wincmd w")
			-- 		vim.cmd("silent make build")
			-- 	end,
			-- 	"build with copen",
			-- },
			b = { _cmd("Task start cargo build "..build_settings), "build" },
			c = {
				function()
					vim.cmd("Task start cargo clippy "..build_settings)
				end,
				"clippy tests examples",
			},
			C = { _cmd("RustOpenCargo"), "Open Cargo.toml" },
			d = { _cmd("RustOpenExternalDocs"), "Open Docs" },
			e = { _cmd("RustExpandMacro"), "Expand Macro" },
			f = { _cmd("RustFmt"), "format" },
			h = { _cmd("RustHoverActions"), "hover-action" },
			i = { require("rust_funcs").toggle_inlay_hints, "toggle inlay hints" },
			o = { require("rust_funcs").toggle_inlay_hinst_all_lines, "toggle line inlay-hints" },
			l = { rust_funcs.run.something_good, "something good" },
			p = { require("rust_funcs").cargo_run, "cargo run" },
			r = { _cmd("CargoReload"), "cargo-reload" },
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
                rust_funcs.run.nearest_test,
				"cargo test",
			},
			-- T = { rust_funcs.tree.show, "module tree" },
			-- T = { rust_funcs.tree.lib, "module tree" },
			-- T = { rust_funcs.tree.bin, "module tree" },
		},
	})

	-- rust_funcs.jump.on_attach(client, bufnr)

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
		-- executor = require("rust-tools.executors").toggleterm,
		executor = require("rust_funcs").run.rust_tools_executor2,
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
					features = {
                        "dev"
                    }
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

				procMacro = {
					enable = false,
				},
				diagnostics = {
					enable = false,
					disabled = { "unresolved-proc-macro" },
				},
				check = {
					command = "clippy",
					-- extraArgs = {
					-- 	"--tests",
					-- 	-- "--example temp",
					-- 	-- "--features=all",
					-- },
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
        cmd = {"/home/viktorhg/git-repos/ra-multiplex/target/release/ra-multiplex", "client"},
            -- cmd = {"clangd"}
			-- cmd = "rust-analyzer",
			-- cmd = "nice --10 rust-analyzer",
		handlers = {
			-- vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
			-- vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })
			["textDocument/hover"] = require("vim.lsp").with(vim.lsp.handlers.hover, {
				-- border = "single",
				border = "rounded",
				width = 80,
			}),
            ["textDocument/publishDiagnostics"] = vim.lsp.with(
              vim.lsp.diagnostic.on_publish_diagnostics, {
                -- delay update diagnostics
                update_in_insert = false,
              }
            )
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
