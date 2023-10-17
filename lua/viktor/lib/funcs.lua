M = {}



M.mysplit = function(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

local function is_cmd_map(str) 
    return string.sub(str, 1, 5) == "[cmd]"
end

M.serialize_table = function(t)
  local serializedValues = {}
  local value, serializedValue
  for i=1,#t do
    value = t[i]
    serializedValue = type(value)=='table' and serialize(value) or value
    table.insert(serializedValues, serializedValue)
  end
  return string.format("{ %s }", table.concat(serializedValues, ', ') )
end

local wk = require('which-key')

-- cmd_mappings
function Cmd_mappings(mode, tab, prefix)
    if prefix == nil then prefix = '' end

    for k, v in pairs(tab) do
        local bind = prefix..k

        if k == "name" then
            local stt = {}
            stt[prefix] = {name = v}
            wk.register(stt, {})
        elseif type(v) == 'table' then
            if v['require'] and v['cmd'] then
                local cmd = v['cmd']
                if type(v['args']) == 'table' then
                    cmd = cmd..'('..M.serialize_table(v['args'])..')'
                elseif type(v['args']) == 'number' then
                    cmd = cmd..'('..v['args']..')'
                else
                    cmd = cmd..'()'
                end
                local req = 'lua require("'..v['require']..'").'
                vim.keymap.set(mode, bind, '<cmd>'..req..cmd..'<cr>')
            elseif v['args'] then
                local cmd = table.remove(v, 1)
                vim.keymap.set(mode, bind, function()
                    cmd(table.unpack(v))
                end)
            else
                if type(v[1]) == 'function' then
                    vim.keymap.set(mode, bind, v[1])
                    if 2 == #v then
                        wk.register({
                            [k] = { v[1], v[2]}
                        }, {prefix=prefix})
                        print(k, prefix)
                    end
                else
                    Cmd_mappings(mode, v, bind)
                end
            end
        elseif type(v) == 'string' then
            if is_cmd_map(v) then
                v = "<cmd>" .. string.sub(v, 7, -1) .. "<cr>"
            end
            vim.keymap.set(mode, bind, v)
        elseif type(v) == 'function' then
            vim.keymap.set(mode, bind, v)
        end
    end
end

M.cmd_mappings = Cmd_mappings

-- M.cmd_mappings = cmd_mappings


-- cmd_mappings('n', {
--     ['t'] = {
--         ["g"] = {
--             ['s'] = '[cmd] Telescope git_status',
--             ['b'] = '[cmd] Telescope git_branches',
--             ['c'] = '[cmd] Telescope git_commits',
--             ['d'] = { require = 'harpoon.mark', cmd = 'add_file', args = {'2'} },
--
--             -- require_map('h\'', 'harpoon.mark', 'add_file')
--         },
--     }
-- })
return M
