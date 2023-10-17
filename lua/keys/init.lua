M = {}

---@enum JUMP_METHOD
JUMP_METHOD = {
    TROUBLE = "Trouble",
    QUICKFIX_LIST = "qf",
    LOCATION_LIST = 'loclist'
}


---@class JumpMethods
local JumpMethods = {
    trouble_conf = function()
        return { skip_groups = true, jump = true }
    end,
    loclist_next = function()
        if pcall(vim.cmd.lnext) == false then
            vim.cmd.llast()
        end
    end,
    loclist_prev = function()
        if pcall(vim.cmd.lprev) == false then
            vim.cmd.lfirst()
        end
    end,
    qlist_next = function()
        if pcall(vim.cmd.cnext) == false then
            vim.cmd.clast()
        end
    end,
    qlist_prev = function()
        if pcall(vim.cmd.cprev) == false then
            vim.cmd.cfirst()
        end
    end,
}

function JumpMethods:trouble_next()
    local succ, _ = pcall(require('trouble').next, JumpMethods.trouble_conf())
    if succ == false then
        require('trouble').last()
    end
end

function JumpMethods:trouble_prev()
    local succ, _ = pcall(require('trouble').previous, JumpMethods.trouble_conf())
    if succ == false then
        require('trouble').first()
    end
end

---@param file_type JUMP_METHOD
function JumpMethods:register(file_type)
    ---@type function
    local jump_next_cmd
    ---@type function
    local jump_prev_cmd

    ---@type table
    local opts = {}
    if file_type == JUMP_METHOD.TROUBLE then
        jump_prev_cmd = JumpMethods.trouble_prev
        jump_next_cmd = JumpMethods.trouble_next
    elseif file_type == JUMP_METHOD.QUICKFIX_LIST then
        jump_prev_cmd = JumpMethods.qlist_prev
        jump_next_cmd = JumpMethods.qlist_next
    elseif file_type == JUMP_METHOD.LOCATION_LIST then
        jump_prev_cmd = JumpMethods.loclist_prev
        jump_next_cmd = JumpMethods.loclist_next
    else
        error("the given filetype '" .. file_type .. "' does not work")
    end

    vim.keymap.set("n", "N", jump_prev_cmd, opts)
    vim.keymap.set("n", "n", jump_next_cmd, opts)
end

function JumpMethods:unregister()
    local keys2 = { "*", "#", "/", "n", "N" }
    for _, u in ipairs(keys2) do
        vim.keymap.del('n', u)
    end
end

---@param file_type JUMP_METHOD
M.register_jump_mappings = function(file_type)
    local status, _ = JumpMethods:register(file_type)
    if status == false then
        return
    end

    -- set deactivation keymaps to "/"
    local keys = { "*", "#", "/" }
    for _, v in ipairs(keys) do
        vim.keymap.set("n", v, JumpMethods.unregister, {})
    end
end

return M
