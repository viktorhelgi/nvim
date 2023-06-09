

function ColorMyPencils(color)
	-- color = color or "catppuccin-mocha"
    --
    color = color or "catppuccin-macchiato"
	vim.cmd.colorscheme(color)

    if color == 'catppuccin-macchiato' then
	    vim.api.nvim_set_hl(0, "LineNr", { fg="#6e738d", italic=true, bold=false})
	    vim.api.nvim_set_hl(0, "CursorLineNr", { bold=true })
    end

    if color == 'catppuccin' then
	    vim.api.nvim_set_hl(0, "LineNr", { fg="#6e738d", italic=true, bold=false})
	    vim.api.nvim_set_hl(0, "CursorLineNr", { bold=true })
    end
end

ColorMyPencils()

