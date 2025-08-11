-- return {
-- 	require("viktor.lsp.ruff_lsp"),
--     -- require('viktor.lsp.pylyzer')
-- 	-- require("viktor.lsp.pylsp"),
-- 	require("viktor.lsp.pyright"),
-- }
RegisterFTKeymaps.Python = function()
	local bufnr = vim.api.nvim_get_current_buf()

	-- require('viktor.config.plugin.neotest').on_attach('python', 0)
	-- require('lsp_signature').on_attach(require('viktor.config.plugin.lsp_signature_configs'), bufnr)
	vim.cmd('set colorcolumn=89')

	require('which-key').register({
        K = { vim.lsp.buf.hover, "hover"},
        g = {
            name = "goto",
            r = {
                vim.lsp.buf.references,
                "references"
            }
        },

		['<leader>'] = {
            l = {
                name = "lsp",
                a = {
                    "<CMD> lua vim.lsp.buf.code_action()  <CR>",
                    "code-action"
                }
            },
            -- m = {
            --     name = "molten",
            --     r = {
            --         "<CMD> Molten"
            --     }
            -- },
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

vim.lsp.config('*', {
    on_attach = function(client, bufnr)
        RegisterFTKeymaps.Python()
        -- -- overwrites omnifunc/tagfunc set by some Python plugins to the
        -- -- default values for LSP
        -- vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', {buf = bufnr})
        -- vim.api.nvim_set_option_value('tagfunc', 'v:lua.vim.lsp.tagfunc', {buf = bufnr})
        --
        -- vim.keymap.set({'n', 'v'}, 'K', vim.lsp.buf.hover, { buffer = bufnr })
        -- vim.keymap.set({'n', 'v'}, '<F4>', vim.lsp.buf.format, { buffer = bufnr })
        -- vim.keymap.set('n', 'gu', vim.lsp.buf.references, { buffer = bufnr })
        -- vim.keymap.set('n', 'gr', vim.lsp.buf.rename, { buffer = bufnr })
        --
        -- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        --     vim.lsp.diagnostic.on_publish_diagnostics, {
        --         signs = true,
        --         underline = true,
        --         virtual_text = true
        --     }
        -- )
    end
})

return {
    name = "python-server",
    cmd = { "pyright", "ruff_lsp" },
    on_attach = function(client, bufnr)
        -- extend global configuration
        vim.lsp.config['*'].on_attach(client, bufnr)

        -- "fix" gq
        vim.api.nvim_buf_set_option(bufnr, "formatexpr", "");
    end
}
