require("neotest").setup({
    adapters = {
       -- require("neotest-python")({
        --            dap = { justMyCode = false },
        --            runner = 'unit'
        --
        --        }),
       require("neotest-plenary"),
       require("neotest-vim-test")({
           ignore_file_types = { "python", "vim", "lua", "cpp" },
       }),
    },
})

-- require('neotest.config').adapters[1].root
-- require('neotest-python').discover_positions()
