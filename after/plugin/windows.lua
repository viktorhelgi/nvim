
require('windows').setup({
   autowidth = {
      enable = false,
      winwidth = 5,
      filetype = {
         help = 2,
      },
   },
   ignore = {
      buftype = { "quickfix" },
      filetype = { "NvimTree", "neo-tree", "undotree", "gundo" }
   },
   animation = {
      enable = true,
      duration = 100,
      fps = 30,
      easing = "in_out_sine"
   }
})


local function cmd(command)
   return table.concat({ '<Cmd>', command, '<CR>' })
end
vim.keymap.set('n', '<C-w>z', cmd 'WindowsMaximize')
vim.keymap.set('n', '<C-w>_', cmd 'WindowsMaximizeVertically')
vim.keymap.set('n', '<C-w>|', cmd 'WindowsMaximizeHorizontally')
vim.keymap.set('n', '<C-w>=', cmd 'WindowsEqualize')
