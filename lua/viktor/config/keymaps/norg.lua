vim.cmd([[
    autocmd FileType norg lua RegisterFTKeymaps.Norg()
]])

RegisterFTKeymaps.Norg = function()
    local bufnr = vim.api.nvim_get_current_buf()

	-- vim.cmd("set shiftwidth=2")
	vim.cmd("set conceallevel=2")
    vim.cmd("set shiftwidth=2")

	-- vim.cmd("set textwidth=100")
	-- vim.cmd("set wrap")
    -- vim.api.nvim_buf_set_option(bufnr, 'shiftwidth', 2)
    -- vim.api.nvim_buf_set_option(bufnr, 'conceallevel', 2)
    vim.cmd('setlocal colorcolumn=100')

	require("which-key").register({
		["'"] = {
			L = {
				"<CMD>e ~/.config/nvim/lua/viktor/config/plugin/neorg.lua<CR>",
				"Goto OnAttach File",
			},
            P = {
				"<CMD>e ~/.config/nvim/lua/viktor/lsp/norg.lua<CR>",
				"Goto Config File",
            }
		},
        ["<leader>"] = {

        }
	}, { -- Options
		mode = "n",
		noremap = true,
		silent = true,
		buffer = bufnr,
	})
end
