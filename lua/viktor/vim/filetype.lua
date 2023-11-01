vim.cmd([[
autocmd BufRead,BufNewFile *.dockerfile set filetype=dockerfile
]])

local libs = require('viktor.vim.libs')

vim.filetype.add({
	extension = {
        -- [""] = "docker",
		mdx = 'markdown',
		docker = 'dockerfile',
        -- dockerfile_dfi = 'docker',
		-- [".dockerfile"] = 'dockerfile'
		conf = function(path, _)
			local conf_pairs = {
				{ filetype = 'tmux', directory = '/home/viktorhg/.config/tmux' },
			}
			for _, item in pairs(conf_pairs) do
				if libs.file_is_child_of_directory(path, item.directory) then
					return item.filetype
				end
			end
			return 'conf'
		end,
	},
    pattern = {
        [".*/dockerfile_.*"] = "dockerfile",
    }
})

-- local ft_to_parser = require("nvim-treesitter.parsers").filetype_to_parsername
-- ft_to_parser.mdx = "markdown"

vim.treesitter.language.register('markdown', { 'md', 'mdx' })
