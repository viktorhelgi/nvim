vim.o.pumblend = 0
vim.o.winblend = 0
require('catppuccin').setup({
	transparent_background = true, -- disables setting the background color.
	dim_inactive = {
		enabled = false, -- dims the background color of inactive window
	},
	custom_highlights = function(_)
		return {}
	end,
})
