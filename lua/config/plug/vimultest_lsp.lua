


-- This will separate out the module name and arguments to provide to the
-- nvim-dap-python adapter.

-- To provide this to vim-ultest, call the setup function, providing a table with
-- a 'builders' entry, with your language mapped to the builder. If you require
-- multiple runners, the key can be in the form of '<language>#<runner>'
-- (Example: 'python#pytest')
  
require("ultest").setup({
	builders = {
		['python#pytest'] = function(cmd)
			-- The command can start with python command directly or an env manager
			local non_modules = {'python', 'pipenv', 'poetry'}
			-- -- Index of the python module to run the test.
			local module
			if vim.tbl_contains(non_modules, cmd[1]) then
				module = cmd[3]
			else
				module = cmd[1]
			end
			-- Remaining elements are arguments to the module
			local args = vim.list_slice(cmd, module_index + 1)
			return { dap = { type = 'python', request = 'launch', module = module, args = args } }
		end,
	}
})
