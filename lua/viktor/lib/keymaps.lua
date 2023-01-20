
M = {}

local opt_e = { silent = false } --empty opt for maps with no extra options
local opt_n = { silent = false, noremap = true } --empty opt for maps with no extra options
local opt_s = { silent = true } --empty opt for maps with no extra options
local opt_sn = { silent = true, noremap = true }
vim.g.mapleader = ' ' -- Map leader key to space
vim.g.maplocalleader = ','

M.map = function(mode, bind, exec, opts)
    --[[
        inputs:
            - mode: Type, whether in all, normal, insert etc. (reference: https://github.com/nanotee/nvim-lua-guide#defining-mappings) 
            - bind: Keybind. Just like normal vim way
            - exec: command to execute
            - options: ...
    --]]
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, bind, exec, opts)
end

local function process_opts(opt)
    if opt==nil then
        return opt_sn
    end
    return opt
end
local function process_func(func)
    if type(func)=="table" then
        return table.concat(func, '<CR>:')
    end
    return func
end

local function nmap(bind, func, opt)
    -- print('nmap')
    func = process_func(func)
    opt = process_opts(opt)
    local exec_func = ':'..func..'<CR>'
    local echo_func = ':echo "'..func..'"<CR>'
    -- print(echo_func)
    map('n', '<leader>'..bind, exec_func .. echo_func , opt)
    -- print('-------------------------------')
end
local function snmap(bind, func, opt, mode)
    if mode==nil then
        mode='n'
    end
    -- print('snmap')
    local func_str = process_func(func)
    local exec_func = ':'..func_str..'<CR>'
    local echo_func = ':echo "'..func_str..'"<CR>'
    opt = process_opts(opt)
    --vim.pretty_print(func)
    map(mode, '<leader>'..bind, exec_func .. echo_func , opt)
    -- print('--------------------------')
end

local function amap(bind, func, opt)
    snmap(bind, func, opt, '')
end

-- -- }}}
-- -- {{{ function unmap(mode, bind)

local function unmap(mode, bind)
    --[[ Umapping
    --unmap('n', '<leader>f')
    --]]
    vim.api.nvim_del_keymap(mode, bind)
end

-- -- }}}
-- -- {{{ function mysplit(inputstr, sep)

local function mysplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

-- -- }}}
-- -- {{{ function mm(file)

local function mm(file)
    local t = vim.fn.expand(file)
    return t
end

-- -- }}}
-- -- {{{ function mm(file)

local function fterm_run(command)
    return ":lua require('FTerm').run(" .. command .. ")<CR>"
end
