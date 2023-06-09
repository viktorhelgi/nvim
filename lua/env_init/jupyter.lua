M = {}

M.opts = { noremap = true, silent = false, buffer = 0 }

M.set = function(mode)
    print("Jupyter keymappings set")
    vim.keymap.set("n", "<leader>;", function()
        vim.cmd("call jupyter_ascending#execute()")
    end, {noremap = true, silent = false, buffer = 0, desc = "execute"})
    vim.keymap.set("n", "<leader>rn", function()
        vim.cmd("w")
        vim.cmd("call jupyter_ascending#execute()")
    end, {noremap = true, silent = false, buffer = 0, desc = "execute"})
    vim.keymap.set("n", "<leader>ra", function()
        vim.cmd("call jupyter_ascending#execute_all()")
    end, {noremap = true, silent = false, buffer = 0, desc = "execute all"})
    vim.keymap.set("n", "<leader>rR", function()
        vim.cmd("call jupyter_ascending#restart()")
    end, {noremap = true, silent = false, buffer = 0, desc = "restart"})
    local markdown_bar =
        "[markdown] - ||===|MARKDOWN|=====|MARKDOWN|=====|MARKDOWN|=====|MARKDOWN|=====|MARKDOWN|=====|"
    -- local code_bar = "[code] - ||=======|CODE|=======|CODE|=======|CODE|=======|CODE|=======|CODE|=======|CODE|====|"
    local code_bar = "[code]"

    vim.api.nvim_buf_set_keymap(0, "n", "gn", "/# %% [code\\]<CR>zz", { noremap = true, silent = false })
    vim.api.nvim_buf_set_keymap(0, "n", "gp", "?# %% [code\\]<CR>zz", { noremap = true, silent = false })
    vim.api.nvim_buf_set_keymap(
        0,
        "n",
        "<leader>cc",
        "?# %%<CR>C# %% " .. code_bar .. "<C-c><C-o>",
        { noremap = true, silent = false }
    )
    vim.api.nvim_buf_set_keymap(
        0,
        "n",
        "<leader>cnc",
        "O# %% " .. code_bar .. "<C-c><<<",
        { noremap = true, silent = false }
    )
    vim.api.nvim_buf_set_keymap(
        0,
        "n",
        "<leader>cnm",
        "O# %% " .. markdown_bar .. "<C-c><<<",
        { noremap = true, silent = false }
    )
    vim.api.nvim_buf_set_keymap(
        0,
        "n",
        "<leader>cm",
        "?# %%<CR>C# %% " .. markdown_bar .. "<C-c><C-o>",
        { noremap = true, silent = false }
    )
end

M.del = function()
    print("Jupyter keymappings removed (almost)")
    vim.keymap.del("n", "<leader>ra", M.opt)
    vim.keymap.del("n", "<leader>rn", M.opt)
    vim.keymap.del("n", "<leader>rR", M.opt)
end

return M
