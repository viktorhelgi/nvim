-- In init.lua or filetype.nvim's config file
require("filetype").setup({
    overrides = {
        extensions = {
            -- Set the filetype of *.pn files to potion
        },
        literal = {
            -- Set the filetype of files named "MyBackupFile" to lua
            MyBackupFile = "lua",
        },
        complex = {
            -- Set the filetype of any full filename matching the regex to gitconfig
            [".*git/config"] = "gitconfig", -- Included in the plugin
        },

        -- The same as the ones above except the keys map to functions
        function_extensions = {
            -- ["cpp"] = function()
            --     vim.bo.filetype = "cpp"
                -- Remove annoying indent jumping
                -- vim.bo.cinoptions = vim.bo.cinoptions .. "L0"

                -- vim.cmd('syn region myFold start="\\#ifdef" end="\\#endif" transparent fold')
                -- vim.cmd('syn sync fromstart')
                -- vim.cmd('set foldmethod=syntax')
            -- end,
        },
    },
})

