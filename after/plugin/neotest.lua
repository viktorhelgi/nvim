require("neotest").setup({
	adapters = {
		require("neotest-python")({
			dap = { justMyCode = false },
			args = { "--disable-warnings" ,"-s" },
			-- args = { "--log-level", "DEBUG" },
		}),
		require("neotest-rust")({
			-- args = { "--no-capture" },
		}),
		require("neotest-plenary"),
		-- require("neotest-vim-test")({
		--   ignore_file_types = { "python", "vim", "lua" },
		-- }),
	},
    -- consumers = {
        -- require("neotest").summary
--
    -- }
    quickfix = {
      enabled = true,
      open = false
      -- open = function() vim.cmd('Trouble quickfix') end
    },
	-- quickfix = {
	-- 	enabled = true,
 --        -- open = 'copen'
	-- 	-- open = true,
	-- 	-- open = function() require('bqf.qfwin.handler').open(false, false, nil, nil) end
	-- 	-- open = function() vim.cmd('copen') end
	-- 	-- open = function ()
	-- 	--     _G._open_qfl()
	-- 	--     vim.cmd('wincmd w')
	-- 	-- end
	-- },
    diagnostic = {
        enabled = true
    },
	summary = {
        open = "leftabove vsplit | vertical resize 50",
      -- open = "botright vsplit | vertical resize 50"
	--     mappings = {
	--         mark = 'm',
	--     }
	}
})
