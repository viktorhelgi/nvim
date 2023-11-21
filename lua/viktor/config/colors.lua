

function ColorMyPencils(color)
    -- color = color or "nordic"
    -- color = color or "catppuccin"
	-- color = color or "catppuccin-frappe"
	-- color = color or "gruvbox"
    -- color = color or "nightcity-afterlife"
    color = color or "kanagawa-dragon"
    -- color = color or "catppuccin-macchiato"
    -- color = color or "gruvbox-material"

	vim.cmd("colorscheme "..color)

    vim.cmd("hi Normal guibg=none")

    -- if color == 'nightfox' then
	   --  vim.api.nvim_set_hl(0, "MiniCursorword", { underline=true})
	   --  vim.api.nvim_set_hl(0, "CursorLineNr", { bold=true })
    -- end
    --
    -- if color == 'catppuccin-macchiato' or color == 'catppuccin' then
	   --  vim.api.nvim_set_hl(0, "LineNr", { fg="#7a7f97", italic=true, bold=false})
	   --  vim.api.nvim_set_hl(0, "CursorLineNr", { bold=true })
    -- end
    --
    -- vim.cmd('highlight! HarpoonInactive guibg=NONE guifg=#7a7f97')
    -- vim.cmd('highlight! HarpoonActive guibg=NONE guifg=white')
    -- vim.cmd('highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7')
    -- vim.cmd('highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7')
    -- vim.cmd('highlight! TabLineFill guibg=NONE guifg=white')
end

ColorMyPencils()
