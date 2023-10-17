local neotest = require("neotest")
local neotest_rust = require('neotest-rust')

local function rust_analyzer(bufnr)
	local options = { buffer = bufnr }
	vim.keymap.set("n", "'r", function()
		neotest.output.open({ enter = true, last_run = true, auto_close = false })
	end, options)

	vim.keymap.set("n", "'l", function()
		neotest.output.open({
            enter = true,
            last_run = true,
            auto_close = false,
            open_win = function()
                vim.cmd('vertical split')
                return vim.api.nvim_get_current_win()
            end
        })

	end, options)

	vim.keymap.set("n", "<leader>rl", neotest.run.run_last, options)

	vim.keymap.set("n", "]e", function()
		neotest.jump.next({status="failed"})
	end, options)
	vim.keymap.set("n", "[e", function()
		neotest.jump.prev({status="failed"})
	end, options)

	vim.keymap.set("n", "<leader>rN", function()
		neotest.run.run({ extra_args = { "--success-output=immediate" }})
	end, { buffer = bufnr })

end

local function python(bufnr)

	vim.keymap.set("n", "<leader>rq", function()
		require('neotest.consumers.quickfix')(require('neotest.client').neotest.client)
	end, { buffer = bufnr })

    
	-- vim.keymap.set("n", "<leader>rN", function()
	-- 	neotest.run.run({ extra_args = { "-s" } })
	-- end, { buffer = bufnr })

	vim.keymap.set("n", "<leader>rd", function()
		require("neotest").run.run({ strategy = "dap" })
	end, { buffer = bufnr })

	vim.keymap.set("n", "'r", function()
		vim.cmd('let @/="^>"')
		local _f = function(key)
			vim.keymap.del("n", key)
		end
		_, _ = pcall(_f, "n")
		_, _ = pcall(_f, "N")
		neotest.output.open({ enter = true, last_run = true, auto_close = false })
	end, {})

	vim.keymap.set("n", "<leader>ra", neotest.run.run_last, { buffer = bufnr })

end

return {
	on_attach = function(client, bufnr)
        -- require('neotest').diagnostic
		local options = { buffer = bufnr }

		-- vim.keymap.set("n", "<leader>rn", function()
		-- 	neotest.run.run()
		-- end, options)

		vim.keymap.set("n", "<leader>rf", function()
			neotest.run.run(vim.fn.expand("%"))
		end, options)

		vim.keymap.set("n", "<leader>rM", function()
			neotest.summary.run_marked()
		end, options)

		vim.keymap.set("n", "<leader>ro", function()
			neotest.summary.toggle()
		end, options)

		-- vim.keymap.set("n", "<leader>ro", function()
		-- 	neotest.output_panel.open()
		-- end, options)

		-- vim.keymap.set("n", "<leader>rt", function()
		-- 	neotest.output.open({})
		-- end, options)

		vim.keymap.set("n", "<leader>rs", function()
			neotest.run.run(vim.fn.getcwd())
		end, options)

		vim.keymap.set("n", "]t", neotest.jump.next, options)
		vim.keymap.set("n", "[t", neotest.jump.prev, options)

		if client == "python" then
			python(bufnr)
		elseif client.name == "rust_analyzer" then
			rust_analyzer(bufnr)
		end
	end,
}

-- require('neotest.consumers.quickfix').
-- vim.keymap.set('n', "'c", function()
--     neotest.output_panel.open()
-- end, {})

-- vim.keymap.set('n', '<leader>r/', function()
--     vim.cmd('let @/="^>"')
--     -- vim.api.nvim_set_keymap('n', 'N', ':cp<CR>', {})
--     -- vim.api.nvim_set_keymap('n', 'n', '\^><CR>', {})
--
--     -- set deactivation keymaps to "/"
--     vim.api.nvim_set_keymap('n', '/',
--         ":lua vim.api.nvim_del_keymap('n', 'N')<CR>" ..
--         ":lua vim.api.nvim_del_keymap('n', 'n')<CR>" ..
--         ":lua vim.api.nvim_del_keymap('n', '/')<CR>/", {})
-- end, {buffer=true})

-- summary
--   clear_marked(args)
--   close()
--   expand(self, pos_id, recursive)
--   marked()
--   open()
--   run_marked(args)
--   target(adapter_id, position_id)
--   toggle()
-- run
--   adapters()
--   attach(args)
--   get_last_run()
--   run(args)
--   run_last(args)
--   stop(args)
-- summary
--   clear_marked(args)
--   close()
--   expand(self, pos_id, recursive)
--   marked()
--   open()
--   run_marked(args)
--   target(adapter_id, position_id)
--   toggle()
-- state
--   adapter_ids()
--   positions(adapter_id, args)
--   status_counts(adapter_id, args)
-- vim.keymap.set('n', '<leader>rso', neotest.summary.open, {buffer=true})
-- vim.keymap.set('n', '<leader>rsc', neotest.summary.close, {buffer=true})
-- vim.keymap.set('n', '<leader>rsm', neotest.status., {buffer=true})
