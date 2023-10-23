local wk = require('which-key')

wk.setup({
    plugins = {
        spelling = {
            enabled = true,
            suggestions = 40,
        },
    },
    key_labels = {
        ['<space>'] = 'SPC',
        ['<CR>'] = 'ENTR',
        ['<tab>'] = 'TAB',
        ['<bs>'] = 'BKSPC',
    },
    layout = {
        align = 'center',
    },
})
