require("gitsigns").setup({
    trouble = false,
	signs = {
		add = { text = "│" },
		change = { text = "│" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
	signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
	numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
	linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
	watch_gitdir = {
		interval = 1000,
		follow_files = true,
	},
	attach_to_untracked = true,
	current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
		ignore_whitespace = false,
	},
	current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil, -- Use default
	max_file_length = 40000, -- Disable if file is longer than this (in lines)
	preview_config = {
		-- Options passed to nvim_open_win
		border = "single",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},
	yadm = {
		enable = false,
	},
	-- on_attach = function(bufnr)
	-- 	-- local gs = package.loaded.gitsigns
 --        local gs = require('gitsigns.actions')
	--
	-- 	-- Navigation
	-- 	vim.keymap.set("n", "]g", function()
	-- 		if vim.wo.diff then
	-- 			return "]g"
	-- 		end
	-- 		vim.schedule(function()
	-- 			gs.next_hunk()
	-- 		end)
	-- 		return "<Ignore>"
	-- 	end, { expr = true, buffer = bufnr })
	--
	-- 	vim.keymap.set("n", "[g", function()
	-- 		if vim.wo.diff then
	-- 			return "[g"
	-- 		end
	-- 		vim.schedule(function()
	-- 			gs.prev_hunk()
	-- 		end)
	-- 		return "<Ignore>"
	-- 	end, { expr = true, buffer = bufnr })
	--
	-- 	-- Actions
	-- 	vim.keymap.set({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", {buffer = bufnr, desc = "stage hunk"})
	-- 	vim.keymap.set({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", {buffer = bufnr, desc = "reset hunk"})
	-- 	vim.keymap.set("n", "<leader>hS", gs.stage_buffer, { buffer = bufnr , desc = "Stage Buffer"})
	-- 	vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { buffer = bufnr, desc = "Undo stage hunk"})
	-- 	-- vim.keymap.set("n", "<leader>hR", gs.reset_buffer, { buffer = bufnr , desc = "reset buffer"})
	-- 	vim.keymap.set("n", "<leader>hR", function() vim.cmd('!git reset '..vim.fn.expand('%')) end, { buffer = bufnr , desc = "reset buffer"})
	-- 	vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr , desc = "preview hunk"})
	-- 	vim.keymap.set("n", "<leader>hb", function()
	-- 		gs.blame_line({ full = true })
	-- 	end, { buffer = bufnr, desc = "blame line" })
	-- 	-- vim.keymap.set("n", "<leader>tb", gs.toggle_current_line_blame, { buffer = bufnr, desc = "toggle current line blame" })
	--
	-- 	vim.keymap.set("n", "<leader>hd", function()
 --            vim.cmd("wincmd o")
 --            gs.diffthis()
 --        end, { buffer = bufnr, desc = "diff-this" })
	-- 	vim.keymap.set("n", "<leader>hq", function()
 --            vim.cmd('wincmd h')
 --            vim.cmd('q')
 --        end, { buffer = bufnr, desc = "diff-this" })
	--
	-- 	vim.keymap.set("n", "<leader>hD", function()
	-- 		gs.diffthis("~")
	-- 	end, { buffer = bufnr , desc = "diff-this ~"})
	-- 	vim.keymap.set("n", "<leader>td", gs.toggle_deleted, { buffer = bufnr , desc = "toggle deleted"})
	--
	-- 	-- Text object
	-- 	vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { buffer = bufnr })
	-- end,
})
