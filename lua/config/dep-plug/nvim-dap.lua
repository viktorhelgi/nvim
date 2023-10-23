local dap = require('dap')
dap.adapters.lnnb = {
    type = 'executable',
    command = 'C:/Program Files/LLVM/bin/lldb-vscode', -- adjust as needed, must be absolute path
    -- adapter = 'C:/Users/Lenovo/.vscode/extensions/vadimcn.vscode-lldb-1.7.0/adapter/codelldb.exe',
    name = 'lldb'
}

dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},

    -- 💀
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    -- runInTerminal = false,
  },
}

-- If you want to use this for Rust and C, add something like this:

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- dap.configurations.lua = {
--   {
--     type = 'nlua',
--     request = 'attach',
--     name = "ViktorLuaDebugger",
--     host = '127.0.0.1',
--     -- host = function()
--     --   local value = vim.fn.input('Host [127.0.0.1]: ')
--     --   if value ~= "" then
--     --     return value
--     --   end
--     --   return '127.0.0.1'
--     -- end,
--     port = function()
--       local val = tonumber(vim.fn.input('Port: '))
--       -- assert(val, "Please provide a port number")
--       return val
--     end,
--   }
-- }
--
-- dap.adapters.nlua = function(callback, config)
--   callback({
--       type = 'server',
--       host = "127.0.0.1",
--       port = config.port or 5005
--   })
-- end
