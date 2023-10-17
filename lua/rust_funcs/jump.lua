local M = {}

M.on_attach = function(_, bufnr)
	local searches = require("rust_jump")
	vim.keymap.set(
		"n",
		"<leader>ja",
		"/" .. searches.all.both .. "<CR>:set nohlsearch<CR>",
		{ silent = true, buffer = bufnr }
	)

	vim.keymap.set(
		"n",
		"<leader>ji",
		"/" .. searches.impl.both .. "<CR>:set nohlsearch<CR>",
		{ silent = true, buffer = bufnr, desc = "impl" }
	)
	vim.keymap.set(
		"n",
		"<leader>js",
		"/" .. searches.struct.both .. "<CR>:set nohlsearch<CR>",
		{ silent = true, buffer = bufnr, desc = "struct" }
	)

	vim.keymap.set(
		"n",
		"<leader>jf",
		"/" .. searches.fn.both .. "<CR>:set nohlsearch<CR>",
		{ silent = true, buffer = bufnr, desc = "fn" }
	)
	vim.keymap.set(
		"n",
		"<leader>jn",
		"/" .. searches.fn.both .. "<CR>:set nohlsearch<CR>",
		{ silent = true, buffer = bufnr, desc = "fn" }
	)

	vim.keymap.set(
		"n",
		"<leader>jt",
		"/" .. searches.trait.both .. "<CR>:set nohlsearch<CR>",
		{ silent = true, buffer = bufnr, desc = "trait" }
	)
	vim.keymap.set(
		"n",
		"<leader>je",
		"/" .. searches.enum.both .. "<CR>:set nohlsearch<CR>",
		{ silent = true, buffer = bufnr, desc = "enum" }
	)
	vim.keymap.set(
		"n",
		"<leader>jm",
		"/" .. searches.mod_use.both .. "<CR>:set nohlsearch<CR>",
		{ silent = true, buffer = bufnr, desc = "mod_use" }
	)
	vim.keymap.set(
		"n",
		"<leader>jp",
		"/" .. searches.mod_pub.both .. "<CR>:set nohlsearch<CR>",
		{ silent = true, buffer = bufnr, desc = "mod_pub" }
	)

	-- VIMGREP
	-- both
	vim.keymap.set(
		"n",
		"<leader>gpa",
		'<CR>:vimgrep "' .. searches.all.pub .. '" ./src/**<CR>',
		{ silent = true, buffer = bufnr, desc = "all" }
	)
	vim.keymap.set(
		"n",
		"<leader>gpi",
		'<CR>:vimgrep "' .. searches.impl.pub .. '" ./src/**<CR>',
		{ silent = true, buffer = bufnr, desc = "impl" }
	)
	vim.keymap.set(
		"n",
		"<leader>gps",
		'<CR>:vimgrep "' .. searches.struct.pub .. '" ./src/**<CR>',
		{ silent = true, buffer = bufnr, desc = "struct" }
	)
	vim.keymap.set(
		"n",
		"<leader>gpf",
		'<CR>:vimgrep "' .. searches.fn.pub .. '" ./src/**<CR>',
		{ silent = true, buffer = bufnr, desc = "fn" }
	)
	vim.keymap.set(
		"n",
		"<leader>gpn",
		'<CR>:vimgrep "' .. searches.fn.pub .. '" ./src/**<CR>',
		{ silent = true, buffer = bufnr, desc = "fn" }
	)
	vim.keymap.set(
		"n",
		"<leader>gpt",
		'<CR>:vimgrep "' .. searches.trait.pub .. '" ./src/**<CR>',
		{ silent = true, buffer = bufnr, desc = "trait" }
	)
	vim.keymap.set(
		"n",
		"<leader>gpe",
		'<CR>:vimgrep "' .. searches.enum.pub .. '" ./src/**<CR>',
		{ silent = true, buffer = bufnr, desc = "enum" }
	)
	vim.keymap.set(
		"n",
		"<leader>gpm",
		'<CR>:vimgrep "' .. searches.mod_use.pub .. '" ./src/**<CR>',
		{ silent = true, buffer = bufnr, desc = "mod_use" }
	)
	-- vim.keymap.set("n", "<leader>gpp", '<CR>:vimgrep "'..searches.mod_pub.pub..'" ./src/**<CR>', {silent = true, buffer = bufnr, desc = "mod_pub"})
	-- pub
	vim.keymap.set(
		"n",
		"<leader>ga",
		'<CR>:vimgrep "' .. searches.all.both .. '" ./src/**<CR>',
		{ silent = true, buffer = bufnr, desc = "all" }
	)
	vim.keymap.set(
		"n",
		"<leader>gi",
		'<CR>:vimgrep "' .. searches.impl.both .. '" ./src/**<CR>',
		{ silent = true, buffer = bufnr, desc = "impl" }
	)
	vim.keymap.set(
		"n",
		"<leader>gs",
		'<CR>:vimgrep "' .. searches.struct.both .. '" ./src/**<CR>',
		{ silent = true, buffer = bufnr, desc = "struct" }
	)
	vim.keymap.set(
		"n",
		"<leader>gf",
		'<CR>:vimgrep "' .. searches.fn.both .. '" ./src/**<CR>',
		{ silent = true, buffer = bufnr, desc = "fn" }
	)
	vim.keymap.set(
		"n",
		"<leader>gn",
		'<CR>:vimgrep "' .. searches.fn.both .. '" ./src/**<CR>',
		{ silent = true, buffer = bufnr, desc = "fn" }
	)
	vim.keymap.set(
		"n",
		"<leader>gt",
		'<CR>:vimgrep "' .. searches.trait.both .. '" ./src/**<CR>',
		{ silent = true, buffer = bufnr, desc = "trait" }
	)
	vim.keymap.set(
		"n",
		"<leader>ge",
		'<CR>:vimgrep "' .. searches.enum.both .. '" ./src/**<CR>',
		{ silent = true, buffer = bufnr, desc = "enum" }
	)
	vim.keymap.set(
		"n",
		"<leader>gm",
		'<CR>:vimgrep "' .. searches.mod_use.both .. '" ./src/**<CR>',
		{ silent = true, buffer = bufnr, desc = "mod_use" }
	)
end
return M
