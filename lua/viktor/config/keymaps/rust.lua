vim.cmd([[
    autocmd FileType rust lua RegisterFTKeymaps.RustKeyBindings()
]])

local rust = {
	build_settings = '--release --features mk2-prod',
}

RegisterFTKeymaps.RustKeyBindings = function()
	local bufnr = vim.api.nvim_get_current_buf()

	vim.o.foldmethod = 'marker'

	vim.cmd('set colorcolumn=102')
	vim.cmd('compiler cargo')

    -- stylua: ignore start
	pcall(function() vim.keymap.del('i', '<tab>') end)
	pcall(function() vim.keymap.del('n', 'caÞ') end)
	-- stylua: ignore end

	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	require('lsp_signature').on_attach(require('viktor.config.plugin.lsp_signature_configs'), bufnr)

	require('which-key').register({
		["'"] = {

			d = { require('neotest').output_panel.toggle, 'neotest-open-down' },

			o = {
                -- stylua: ignore
                function() require('neotest').output.open({ enter = true, last_run = true, auto_close = false }) end,
				'neotest-open',
			},

			l = {
				function()
					local open_win = function()
						vim.cmd('split')
						return vim.api.nvim_get_current_win()
					end
                    -- stylua: ignore
                    require('neotest').output.open({ enter = true, last_run = true, auto_close = false, open_win = open_win })
				end,
				'neotest-open-left',
			},
		},

		['['] = {
			name = 'Goto Prev',
            -- stylua: ignore start
			l = { function() require('neotest').jump.prev({ status = 'failed' }) end, 'failed test' },
			t = { function() require('neotest').jump.prev({ status = 'failed' }) end, 'failed test' },
			-- stylua: ignore end
		},

		[']'] = {
			name = 'Goto Next',
            -- stylua: ignore start
			l = { function() require('neotest').jump.next({ status = 'failed' }) end, 'failed test' },
			t = { function() require('neotest').jump.next({ status = 'failed' }) end, 'failed test' },
			-- stylua: ignore end
		},

        -- stylua: ignore
		c = {
			['<leader>'] = {
				function() require('rust_funcs').run.command('cargo run --release --features dev --bin http-server') end,
				'A: cargo run --release --features dev --bin http-server',
			},
			['*'] = {
				function() vim.cmd('Task start cargo clippy ' .. rust.build_settings) end,
				'A: cargo clippy',
			},
			['!'] = {
				function() vim.cmd('Task start cargo check ' .. rust.build_settings) end,
				'A: cargo check',
			},
			['|'] = {
				function() vim.cmd('Task start cargo bench ' .. rust.build_settings) end,
				'A: cargo bench',
			},
			b = {
				function() vim.cmd('Task start cargo build ' .. rust.build_settings) end,
				'A: cargo build',
			},
			l = { require('rust_funcs').run.last_cmd,           'A: run last command' },
            r = { require('rust_funcs').run.with_arguments,     'A: cargo run -- <Prompt>' },
            R = { require('rust_funcs').run.selected_binary,    'A: cargo run --bin <?>' },
		},

		d = {
			name = 'diagnostic',
			s = {
				require('rust_funcs').explain_error.open_popup_here,
				'explain error',
			},
			J = {
				require('rust_funcs').explain_error.print_error_as_json,
				'print error as json',
			},
		},

		g = {
			name = 'Goto',
            -- stylua: ignore start
			c = { function() vim.cmd('RustOpenCargo') end, 'Cargo.toml' },
			h = { function() vim.cmd('RustHoverActions') end, 'hover/actions' },
			p = { function() vim.cmd('RustParentModule') end, 'Parent module' },
			-- stylua: ignore end
		},

		['<leader>'] = {
			c = {
				['*'] = {
                    -- stylua: ignore
                    function() vim.cmd('Task start cargo clippy ' .. rust.build_settings) end,
					'build',
				},
			},
			d = {
				name = 'diagnostic',
				e = { require('rust_funcs').explain_error.open_popup_here, 'explain error' },
			},
			n = {
				name = 'neotest',
                -- stylua: ignore start
                a = {
                    function() require('neotest').run.run(vim.fn.getcwd() .. '/src') end,
                    'all tests in src/',
                },
			    f = {
                    function() require('neotest').run.run(vim.fn.expand('%')) end,
                    'all tests'
                },
			    h = {
                    function() require('neotest').run.run({ extra_args = { '--success-output=immediate' } }) end,
                    'this test'
                },
                l = { require('neotest').run.run_last, 'last test' },
			    m = { require('neotest').summary.run_marked, 'marked tests' },
                s = { require('neotest').summary.toggle, 'open summary' },
				-- stylua: ignore end
			},
			r = {
				name = 'Run',
				-- stylua: ignore start
				b = {
					function() vim.cmd('Task start cargo build ' .. rust.build_settings) end,
					'build',
				},
                c = {
                    function() vim.cmd('Task start cargo clippy ' .. rust.build_settings) end,
                    'clippy tests examples',
                },
                C = {
                    function() vim.cmd('RustOpenCargo') end,
                    'Open Cargo.toml',
                },
                d = {
                    function() vim.cmd('RustOpenExternalDocs') end,
                    'Open Docs',
                },
                e = {
                    function() vim.cmd('RustExpandMacro') end,
                    'Expand Macro',
                },
                -- g = {}
                h = {
                    function() vim.cmd('RustHoverActions') end,
                    'hover-action',
                },
				-- stylua: ignore end
				i = {
					require('rust_funcs').toggle_inlay_hints,
					'toggle inlay hints',
				},
				l = {
					require('rust_funcs').run.something_good,
					'TestNearest',
				},
				m = {
					function()
						local rfile = vim.fn.expand('%:r')
						local module = rfile:sub(rfile:find('/') + 1, -1):gsub('/', '::')
						vim.cmd('Task start cargo nextest run ' .. module)
					end,
					'nextest run',
				},
				o = {
					require('rust_funcs').toggle_inlay_hinst_all_lines,
					'toggle line inlay-hints',
				},
				p = {
					require('rust_funcs').cargo_run,
					'cargo run',
				},
				r = {
				    -- stylua: ignore
                    function() vim.cmd('CargoReload') end,
					'cargo-reload',
				},
				t = {
					require('rust_funcs').run.nearest_test,
					'Test',
				},
			},
		},
	}, { -- Options
		mode = 'n',
		noremap = true,
		silent = true,
		buffer = bufnr,
	})
end
