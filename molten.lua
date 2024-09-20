-- Configuration options
vim.g.molten_output_win_max_height = 12
vim.g.molten_auto_open_output = false
vim.g.molten_image_provider = 'image.nvim'
vim.g.molten_wrap_output = true
vim.g.molten_virt_text_output = true
vim.g.molten_virt_lines_off_by_1 = true

-- Key mappings
vim.keymap.set('n', '<leader>mi', ':MoltenInit<CR>', { silent = true, desc = 'Initialize Molten' })
vim.keymap.set(
	'n',
	'<leader>me',
	':MoltenEvaluateOperator<CR>',
	{ silent = true, desc = 'Molten run operator selection' }
)
vim.keymap.set('n', '<leader>rl', ':MoltenEvaluateLine<CR>', { silent = true, desc = 'Molten evaluate line' })
vim.keymap.set('n', '<leader>rr', ':MoltenReevaluateCell<CR>', { silent = true, desc = 'Molten re-evaluate cell' })
vim.keymap.set(
	'v',
	'<leader>r',
	':<C-u>MoltenEvaluateVisual<CR>gv',
	{ silent = true, desc = 'Molten evaluate visual selection' }
)
vim.keymap.set('n', '<leader>mo', ':noautocmd MoltenEnterOutput<CR>', { silent = true, desc = 'Molten enter output' })
