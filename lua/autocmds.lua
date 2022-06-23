--[[

    autocmds.lua
    This file defines various autocmds that nii-nvim uses

--]]

local cmd = vim.cmd

-- Don't show line numbers on terminal window
cmd([[ au TermOpen term://* setlocal nonumber norelativenumber | setfiletype terminal ]])
cmd([[ au BufEnter  setlocal nowrap ]])



--vim.api.nvim_create_autocmd('BufEnter', {
--  pattern = {'*.rs'},
--  command = 'setlocal nowrap'
--})
-- # vim: foldmethod=marker
--

