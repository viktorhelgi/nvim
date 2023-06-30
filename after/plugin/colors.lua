

function ColorMyPencils(color)
	-- color = color or "catppuccin-mocha"
    --
    color = color or "catppuccin-macchiato"
	vim.cmd.colorscheme(color)

    if color == 'catppuccin-macchiato' then
	    vim.api.nvim_set_hl(0, "LineNr", { fg="#7a7f97", italic=true, bold=false})
	    vim.api.nvim_set_hl(0, "CursorLineNr", { bold=true })
    end

    if color == 'catppuccin' then
	    vim.api.nvim_set_hl(0, "LineNr", { fg="#7a7f97", italic=true, bold=false})
	    vim.api.nvim_set_hl(0, "CursorLineNr", { bold=true })
    end
    vim.cmd('highlight! HarpoonInactive guibg=NONE guifg=#7a7f97')
    vim.cmd('highlight! HarpoonActive guibg=NONE guifg=white')
    vim.cmd('highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7')
    vim.cmd('highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7')
    vim.cmd('highlight! TabLineFill guibg=NONE guifg=white')
end

ColorMyPencils()

