
 
_G.print_table = function(table) 
    vim.cmd("enew")
    vim.api.nvim_buf_set_lines(0,0,1,1, table)
end



_G.create_header = function()
    local c = vim.cmd
    c("winc s")
    c("winc k")
    c("enew")

    c("setlocal nornu")
    c("setlocal nonumber")

    c("setlocal nobuflisted")
    c("setlocal noswapfile")
    vim.api.nvim_buf_set_lines(0,0,1,1, {"","","","","","","","","","","","","","","","","","",})
    c("setlocal nomodifiable")
    c("setlocal buftype=nofile")
    c("setlocal bufhidden=\"wipe\"")

    vim.g.CloseThisWindowIfItsLonely = 1
    
    c("set laststatus=3")
    c("set nocursorline")
    c("12 winc _")
    c("set winfixheight")
    c("winc K")
    c("winc j")
    c("winc l")

end


_G.print_thing = function(word)

    local tab = split(word,':') 

    local count = 0
    for _ in pairs(tab) do
        count = count + 1
    end

    if count ~= 3 then
        return nil
    end


    local file_split = split(tab[1], '\\')
    local file = table.concat(file_split, '/')


    local row = tab[2]
    local col = tab[3]


    vim.cmd('e '..file)
    vim.cmd('call cursor('..row..','..col..')')




    -- local tab = {}
    -- for w in split(word,':') do
    --     table.insert(tab, w)
    -- end
    --
    vim.pretty_print(tab)
end


-- _G.close_header_if_lonely = function()
    -- c = vim.cmd
    -- if c(winnr('$')) == 1 && exists("b:CloseThisWindowIfItsLonely") && b:CloseThisWindowIfItsLonely == 1
    --     quit
    -- endif
-- end


