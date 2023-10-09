vim.cmd('let test#python#runner = \'pytest\'')
vim.cmd('let test#rust#runner = \'cargotest\'')
vim.cmd('let g:test#echo_command = 0')
vim.cmd('let g:test#preserve_screen = 1')
vim.cmd("let test#strategy = 'vimux'")

