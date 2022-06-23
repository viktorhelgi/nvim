
 
_G.print_table = function(table) 
    vim.cmd("enew")
    vim.api.nvim_buf_set_lines(0,0,1,1, table)
end






