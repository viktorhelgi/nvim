vim.cmd([[
    autocmd FileType python lua RegisterFTKeymaps.Python()
]])

local cmp = require('cmp')

local cmp_source = function(wanted_kind)
	return {
		config = {
			sources = cmp.config.sources({
				{
					name = 'nvim_lsp',
					entry_filter = function(entry, _)
						local label = entry.completion_item.label
						local received_kind = require('cmp.types').lsp.CompletionItemKind[entry:get_kind()]

						if wanted_kind == 'Property' then
							if string.sub(label, 0, 1) == '_' then
								return false
							end
							return received_kind == 'Variable'
						end
						return received_kind == wanted_kind
					end,
				},
			}),
		},
	}
end

RegisterFTKeymaps.Python = function()
	local bufnr = vim.api.nvim_get_current_buf()

	-- require('viktor.config.plugin.neotest').on_attach('python', 0)
	require('lsp_signature').on_attach(require('viktor.config.plugin.lsp_signature_configs'), bufnr)
	vim.cmd('set colorcolumn=88')

	require('which-key').register({
		['<leader>'] = {
			r = {
				name = 'ft:Run',
				a = {
					function()
						require('harpoon.tmux').sendCommand('!', _G.last_py_cmd)
					end,
					'ft: run again',
				},
				c = {
					function()
						vim.print('mypy not implemented')
					end,
					'run mypy',
				},
				C = {
					function()
						vim.cmd('e Pipfile' .. vim.bo.filetype)
					end,
					'Open Pipfile',
				},
				d = {
					function()
						vim.print('Not Implemented')
					end,
					'ft: Open Docs',
				},
				f = {
					function()
						local path = require('plenary.path'):new(vim.fn.expand('%'))
						local cmd = 'cd ' .. vim.fn.getcwd() .. ' \r ' .. 'python3 ' .. path .. '\r'
						print(path)
						require('harpoon.tmux').sendCommand('!', cmd)
					end,
					'Run file',
				},
				-- g = {}
				-- i = {},
				-- j = {},
				-- k = {},
				l = {
					function()
						vim.cmd('TestLast')
					end,
					'TestLast',
				},
				L = {
					function()
						require('overseer').run_template({ name = 'Ruff Lint' })
					end,
					'Ruff Lint',
				},
				-- m = {},
				n = {
					function()
						vim.cmd('TestNearest')
					end,
					'TestNearest',
				},
				o = {
					function()
						vim.print('Not Implemented')
					end,
					'toggle line inlay-hints',
				},
				-- q = {},
				-- p = { },
				-- r = { },
				-- s = {},
				t = {
					function()
						local command = 'pytest -s --disable-warnings ' .. vim.fn.expand('%')
						_G.last_py_cmd = command .. ' \r'
						require('harpoon.tmux').sendCommand('!', _G.last_py_cmd)
					end,
					'Test',
				},
				T = {
					function()
						require('harpoon.tmux').sendCommand('!', '\rpytest -s --disable-warnings\r')
					end,
					'pytest',
				},
				-- T = { rust_funcs.tree.show, "module tree" },
				-- T = { rust_funcs.tree.lib, "module tree" },
				-- T = { rust_funcs.tree.bin, "module tree" },
				-- u = {},
				-- v = {},
				w = {
					function()
						local current_word
						local new_word
						vim.ui.input({ prompt = 'current word: ' }, function(input)
							current_word = input
						end)
						vim.ui.input({ prompt = 'new word: ' }, function(input)
							new_word = input
						end)
						vim.cmd('%s/' .. current_word .. '/' .. new_word .. '/g')
					end,
					'replace word',
				},
				-- x = {},
				-- y = {},
				-- z = {},
			},

			w = {
				name = 'Workspace',
				a = { vim.lsp.buf.add_workspace_folder, 'Add Workspace folder' },
				l = {
					function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end,
					'List Workspace folders',
				},
				r = { vim.lsp.buf.remove_workspace_folder, 'Remove Workspace folder' },
			},
		},
	}, { -- Options
		mode = 'n',
		noremap = true,
		silent = true,
		buffer = bufnr,
	})

	require('which-key').register({
		['<C-X>'] = {
            -- stylua: ignore
            ["<C-v>"] = { function() require("cmp").mapping.complete(cmp_source("Variable")) end, "Variable" },
            -- stylua: ignore
            ["<C-p>"] = { function() require("cmp").mapping.complete(cmp_source("Property")) end, "Property" },
            -- stylua: ignore
            ["<C-m>"] = { function() require("cmp").mapping.complete(cmp_source("Module")) end, "Module" },
            -- stylua: ignore
            ["<C-s>"] = { function() require("cmp").mapping.complete(cmp_source("Class")) end, "Class" },
            -- stylua: ignore
            ["<C-f>"] = { function() require("cmp").mapping.complete(cmp_source("Function")) end, "Function" },
		},
		['<C-n>'] = {
			function(fallback)
				if require('cmp').visible() then
					require('cmp').select_next_item()
				else
					fallback()
				end
			end,
			'next item',
		},
		['<C-p>'] = {
			function(fallback)
				if require('cmp').visible() then
					require('cmp').select_prev_item()
				else
					fallback()
				end
			end,
			'prev item',
		},
	}, { -- Options
		mode = 'i',
		noremap = true,
		silent = true,
		buffer = bufnr,
	})
end
