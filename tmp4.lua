-- vim.cmd[[
--     set efm=%EERROR\ in\ %l 
--     " \ %n,%Cline\ %l,%Ccolumn\ %c,%Z%m
-- ]]
vim.o.errorformat = [[%EERROR in %f %l:%c-%k,%C]]

-- %E%f:%l:%c: %trror: %m,%-Z%p^,%+C%.%#
-- %D%*a: Entering directory [`']%f
-- %X%*a: Leaving directory [`']%f
-- %-G%.%#
vim.keymap.set('n', '<leader>co', function()
    vim.cmd('cfile %')
    vim.cmd('copen')
end, {})
