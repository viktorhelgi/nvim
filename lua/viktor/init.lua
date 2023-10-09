require('viktor.plug')
vim.cmd [[packadd packer.nvim]]

-- require('viktor.setup')
require('viktor.config.init')
-- require('config')
require('viktor.lsp.init')
require('viktor.vim.filetype')
require('viktor.query_injections')

