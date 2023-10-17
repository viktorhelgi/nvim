local M = {}

M.to_file = function() 

    local items = vim.fn.getqflist()

    -- local filename
    -- vim.ui.input(
    --     {prompt = "filename: "},
    --     function(f)
    --         filename = f
    --     end
    -- )

    -- local serialized = vim.fn.json_encode(items)

    table.tostring(items)
    print(tostring(items))
    
    -- vim.fn.writefile(
    --     items,
    --     filename
    -- )

end

M.to_file()
