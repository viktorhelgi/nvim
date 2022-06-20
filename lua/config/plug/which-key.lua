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

local keymap = {
    -- {{{
    -- removed h = {
    --     name = 'hop.nvim',
    --     h = { 'hop by word' },
    --     k = { 'hop by word (before cursor)' },
    --     j = { 'hop by word (after cursor)' },
    --     l = { 'hop by word (all windows)' },
    --     f = { 'hop by word (current line)' },
    --     c = { 'hop by given char' },
    --     C = { 'hop by 2 given chars' },
    --     g = { 'hop by pattern' },
    --     n = { 'hop by line start' },
    -- },
    -- }}}
    -- {{{ [a] }}}
    -- {{{ [b]: Buffers
    b = {
        name = 'Buffers',
        f = { 'focus first buffer in buflist' },
        l = { 'focus last  buffer in buflist' },
        j = { 'focus prev buffer in buflist' },
        k = { 'focus next buffer in buflist' },
    },
    -- }}}
    -- {{{ [c]: quick-fix-window
    c = {
        name = 'Quick-Fix',
        d = { 'diag setqflist' },
        o = { 'open qfl' },
        q = { 'close qfl' },
        n = { 'activate n-jump' },
    },
    -- }}}
    -- [d]: Diffview {{{
    d = {
        name = "Diffview",
        a = "HEAD",
        b = "HEAD~1",
        c = "origin/main",
        d = "origin/main...HEAD",
        q = "DiffviewClose",
        t = "DiffviewToggleFiles",
        f = "DiffviewFileHistory",
    },
    -- }}}
    -- {{{ [e]: Extra
    e = {
        name = 'Extra',
        a = 'Aerial',
        e = 'NvimTree',
        h = 'hlsearch!',
        c = 'cd <file>',
        P = {
            name = 'profile',
            b = 'begin',
            e = 'end',
        },
        r = 'tgl rel nr',
        s = {
            name = "set laststatus",
            ["2"] = "set laststatus=2",
            ["3"] = "set laststatus=3",
        },
    },
    -- }}}
    -- {{{ [h]: Harpoon
    h = { 
        name = 'Harpoon',
        t = "Quick Menu",
        ["'"] = "Add File",
        n = "Navigate to Next Mark",
        p = "Navigate to Previous Mark",
        --["1"],
    }, --- }}}
    -- {{{ [g]: Git
    g = {
        name = 'Git',
        d = {
            name = 'Gdiffsplit',
            m = { 'Gdiffsplit master' },
            h = { 'Gdiffsplit HEAD' },
            ["1"] = { 'Gdiffsplit 1 commit back' },
            ["2"] = { 'Gdiffsplit 2 commit back ' },
            ["3"] = { 'Gdiffsplit 3 commit back' },
            ["4"] = { 'Gdiffsplit 4 commit back' },
        },
        s = { 'git status' },
    },
    -- }}}
    -- {{{ [G]: Gitsigns
    G = {
        name = 'Gitsigns',
        s = { 'stage hunk' },
        u = { 'undo stage hunk' },
        r = { 'reset hunk' },
        R = { 'reset buffer' },
        p = { 'preview hunk' },
        b = { 'blame line' },
        S = { 'stage buffer' },
        U = { 'reset buffer index' },
    },
    -- }}}
    -- {{{ [P]: Packer
    P = {
        name = "Packer",
        c = "PackerClean",
        C = "PackerCompile",
        i = "PackerInstall",
        o = "PackerStatus",
        u = "PackerUpdate",
        s = "PackerSync",
        P = "PackerProfile",
        l = "PackerLoad",
        S = {
            name = "PackerSnapshot",
            i = "PackerSnapshot",
            d = "PackerSnaposhotDelete",
            r = "PackerSnaposhotRollback"
        },
        a = ":packadd",
        L = ":packloadall",
        ["'"] = "goto ..~/plug.lua"

    },
    -- }}}
    -- {{{ [s]: alternate buffers
    s = { 'Alternate buffers' },
    -- }}}
    -- {{{ [y]: Yank
    y = {
        name = 'Yank',
        a = { 'buffer' },
        l = { 'line' },
    },
    -- }}}
    -- {{{ [r]: Test 
    -- }}}
    -- {{{ [t]: Telescope
    t = {
        name = "Telescope",
        f = "find files",
        g = "find files*",

        w = "live grep",
        v = "live grep*",
        z = "live grep^",

        r = "resume",
        k = "keymaps",
        h = "help tags",
        s = "lsp DWS sympols",

        b = "file browser",
        m = "file browser*",

        t = "test files",
        d = "directory",
    },
    -- }}}
}


wk.register(keymap, {
    prefix = '<leader>',
})
