
return {
	on_attach = function(client, bufnr)
		local options = { buffer = bufnr }

        vim.keymap.set('n', '<leader>rt', function()
            vim.cmd('Task start cargo nextest run')
        end, options)

        vim.keymap.set('n', '<leader>rm', function()
            local rfile = vim.fn.expand('%:r')
            local module = rfile:sub(rfile:find('/')+1, -1):gsub("/", "::")
            vim.cmd('Task start cargo nextest run ' .. module)
        end, options)

        -- vim.keymap.set('n', '<leader>rb', function()
        --     vim.cmd('Task start cargo bench')
        -- end, options)


	end,
}
