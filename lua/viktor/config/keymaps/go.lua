vim.cmd([[
    autocmd FileType go lua RegisterFTKeymaps.Go()
]])

RegisterFTKeymaps.Go = function() end
