vim.cmd([[
    autocmd FileType python lua _G.PythonKeyBindings()
]])

local cmp = require('cmp')

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

_G.PythonKeyBindings = function()

	require("viktor.config.plugin.neotest").on_attach("python", 0)

	vim.cmd("set colorcolumn=88")

	require("which-key").register({
		g = {
			s = {
				require("lsp_signature").toggle_float_win,
				"toggle signature",
			},
			t = {
				require("telescope.builtin").lsp_type_definitions,
				"type definition",
			},
		},
		["'L"] = {
			"<CMD>e ~/.config/nvim/lua/viktor/lsp/python.lua<CR>",
			"Goto FileType Config",
		},
		["<leader>"] = {
			l = { vim.lsp.buf.code_action, "Code Action" },
			r = {
				j = { require("env_init.jupyter").set, "Set jupyter mappings" },
				l = {
					function()
						-- vim.cmd("cd " .. vim.fn.expand("%:p:h"))
						require("overseer").run_template({ name = "Ruff Lint" })
					end,
					"Ruff Lint",
				},
				p = {
					function()
						local harpoon = require("harpoon.tmux")
						local Path = require("plenary.path")

						local path = Path:new(vim.fn.expand("%"))
						print(path)
						harpoon.sendCommand("!", "cd " .. vim.fn.getcwd() .. " \r " .. "python3 " .. path .. "\r")
					end,
					"Run file",
				},
                n = {
                    function()
                        require('harpoon.tmux').sendCommand("!", "\rpytest -s --disable-warnings\r")
                    end,
                    "Pytest"
                },

				H = {
					function()
						local dirname = vim.fn.expand("%:p:h")
						-- require("harpoon.tmux").sendCommand("0", "|^C\r")
						-- vim.loop.sleep(10)
                        -- stylua: ignore
						require("harpoon.tmux").sendCommand(
							"0",
							"\r"
                                .. "cd /home/viktor/hm/backend" .. "\r"
								.. "git add ruff.toml .pre-commit-config.yaml" .. "\r"
								.. "git commit --amend --no-edit" .. "\r"
                                )
						vim.loop.sleep(10)
                        -- stylua: ignore
						require("harpoon.tmux").sendCommand(
							"0",
							"\r"
								.. "cd " .. dirname .. "\r"
                                .. "git add " .. vim.fn.expand("%:t") .. "\r"
								.. "git commit --m 'testing'"
								.. "\r"
						)
					end,
					"send 'git add/commit to pane 0",
				},
				t = {
					function()
						local command = "pytest -s --disable-warnings " .. vim.fn.expand("%")
                        _G.last_py_cmd = command .. " \r"
						require("harpoon.tmux").sendCommand("!", _G.last_py_cmd)
					end,
					"Run test",
				},
                a = {
                    function()
                        require("harpoon.tmux").sendCommand("!", _G.last_py_cmd)
                    end,
                    "Run last test"
                }
			},
			f = {
				I = {
					function()
						require("harpoon.tmux").sendCommand("0", "isort " .. vim.fn.expand("%") .. "\r")
						vim.loop.sleep(10)
						vim.cmd("e!")
					end,
					"isort",
				},
			},
		},
	}, { -- Options
		mode = "n",
		noremap = true,
		silent = true,
		buffer = vim.api.nvim_get_current_buf(),
	})

	require("which-key").register({
		["<C-X>"] = {
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
		["<C-n>"] = {
			function(fallback)
				if require("cmp").visible() then
					require("cmp").select_next_item()
				else
					fallback()
				end
			end,
			"next item",
		},
		["<C-p>"] = {
			function(fallback)
				if require("cmp").visible() then
					require("cmp").select_prev_item()
				else
					fallback()
				end
			end,
			"prev item",
		},
	}, { -- Options
		mode = "i",
		noremap = true,
		silent = true,
		buffer = vim.api.nvim_get_current_buf(),
	})
end

return {
	require("viktor.lsp.ruff_lsp"),
	require("viktor.lsp.pyright"),
	require("viktor.lsp.pylsp"),
	-- require('viktor.lsp.pylyzer'),
}
