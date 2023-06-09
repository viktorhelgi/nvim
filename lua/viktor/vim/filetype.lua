vim.cmd[[
autocmd BufRead,BufNewFile *.dockerfile set filetype=dockerfile
]]

local libs = require('viktor.vim.libs')

vim.filetype.add({
  extension = {
    mdx = 'markdown',
    -- [".dockerfile"] = 'dockerfile'
    conf = function(path, _)
        local conf_pairs = {
            { filetype = "tmux", directory = "/home/viktorhg/.config/tmux" }
        }
        for _, item in pairs(conf_pairs) do
            if (libs.file_is_child_of_directory(path, item.directory)) then
                return item.filetype
            end
        end
        return "conf"
    end,
  },
  -- filename = {
  --   ['.foorc'] = 'toml',
  --   ['/etc/foo/config'] = 'toml',
  -- },
  -- pattern = {
  --   ['.*/etc/foo/.*'] = 'fooscript',
  --   -- Using an optional priority
  --   ['.*/etc/foo/.*%.conf'] = { 'dosini', { priority = 10 } },
  --   -- A pattern containing an environment variable
  --   ['${XDG_CONFIG_HOME}/foo/git'] = 'git',
  --   ['README.(a+)$'] = function(path, bufnr, ext)
  --     if ext == 'md' then
  --       return 'markdown'
  --     elseif ext == 'rst' then
  --       return 'rst'
  --     end
  --   end,
  -- },
})


-- local ft_to_parser = require("nvim-treesitter.parsers").filetype_to_parsername
-- ft_to_parser.mdx = "markdown"

vim.treesitter.language.register("markdown", {"md", "mdx"})
