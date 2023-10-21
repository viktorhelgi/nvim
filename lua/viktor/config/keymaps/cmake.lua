vim.cmd([[
    autocmd FileType cmake lua RegisterFTKeymaps.CMake()
]])

RegisterFTKeymaps.CMake = function()
    vim.cmd('TSBufDisable highlight')
end

