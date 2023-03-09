M = {
    term = {},
    buf = nil,
    channel = nil
}

local harpoon = {
    term= require('harpoon.term'),
    ui= require('harpoon.ui')
}

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
    print(tab)

    local count = 0
    for _ in pairs(tab) do
        count = count + 1
    end

    if count ~= 3 then
        return nil
    end


    local file_split = split(tab[1], '\\')
    local file = table.concat(file_split, '/')
    print(file)


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

local get_screen_params = function()
    local screen_width = vim.api.nvim_get_option("columns")
    local screen_height = vim.api.nvim_get_option("lines")

    return {
        loc = {
            row = math.floor(screen_height*0.2),
            col = math.floor(screen_width*0.2),
        },
        size = {
            rows = math.floor(screen_height*0.4),
            cols = math.floor(screen_width*0.4),
        }
    }

end

_G.term_float = function(bufnr)

    M.p = get_screen_params()
    if M.buf == nil then
        print("buffer created")
        local buf = vim.api.nvim_create_buf(false, false)

        M.win = vim.api.nvim_open_win(
            buf, true, {
                relative = 'editor',
                width  = M.p.size.cols,
                height = M.p.size.rows,
                row = M.p.loc.row,
                col = M.p.loc.col
            }
        )
        vim.cmd('terminal')
        M.buf = vim.api.nvim_win_get_buf(M.win)


        -- M.channel = vim.api.nvim_open_term(M.buf, {})
        -- vim.api.nvim_buf_set_option(M.buf, 'buftype', '')
    elseif vim.api.nvim_buf_get_number(M.buf) == bufnr then
        print("buffer is open")
        vim.api.nvim_out_write("help\r\n")
        -- vim.api.nvim_chan_send(M.buf.id, "help")
        vim.cmd("set modifiable")
        vim.cmd("insert\ndir")
    else
        print(bufnr)
        print(vim.api.nvim_buf_get_number(M.buf))
        print("buffer not active")
        vim.api.nvim_open_win(
            M.buf, true, {
                relative = 'editor',
                width  = M.p.size.cols,
                height = M.p.size.rows,
                row = M.p.loc.row,
                col = M.p.loc.col
            }
        )
    end
end

_G.split_term = function()

    vim.api.nvim_open_win(0, false,
      {relative='win', width=12, height=3, bufpos={100,10}})

    harpoon.term.sendCommand(3, "prompt cmd$g$s\r")
    harpoon.term.sendCommand(3, "cls\r")
    vim.cmd("split enew")
    vim.cmd("Terminal")
    harpoon.term.gotoTerminal(3)
    vim.cmd("14 winc _")
    vim.cmd("set winfixheight")

    M.term.nr = vim.api.nvim_get_current_buf()
end

-- _G.close_header_if_lonely = function()
    -- c = vim.cmd
    -- if c(winnr('$')) == 1 && exists("b:CloseThisWindowIfItsLonely") && b:CloseThisWindowIfItsLonely == 1
    --     quit
    -- endif
-- end


return M
