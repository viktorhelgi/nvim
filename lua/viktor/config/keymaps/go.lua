vim.cmd([[
    autocmd FileType go lua RegisterFTKeymaps.Go()
]])

RegisterFTKeymaps.Go = function()
	local bufnr = vim.api.nvim_get_current_buf()

	vim.o.foldmethod = 'marker'

	vim.cmd('set colorcolumn=100')

	-- stylua: ignore start
	-- pcall(function() vim.keymap.del('i', '<tab>') end)
	-- pcall(function() vim.keymap.del('n', 'caÞ') end)
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

		['<leader>'] = {
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
				n = { '<CMD> TestNearest <CR>', 'test nearest' },
				l = { '<CMD> TestLast <CR>', 'test last' },
			},
		},
	}, { -- Options
		mode = 'n',
		noremap = true,
		silent = true,
		buffer = bufnr,
	})
end
