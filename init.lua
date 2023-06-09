require('viktor')
require('fidget').setup({})

-- local should_profile = os.getenv("NVIM_PROFILE")
-- if should_profile then
--   require("profile").instrument_autocmds()
--   if should_profile:lower():match("^start") then
--     require("profile").start("*")
--   else
--     require("profile").instrument("*")
--   end
-- end
--
-- local function toggle_profile()
--   local prof = require("profile")
--   if prof.is_recording() then
--     prof.stop()
--     vim.ui.input({ prompt = "Save profile to:", completion = "file", default = "profile.json" }, function(filename)
--       if filename then
--         prof.export(filename)
--         vim.notify(string.format("Wrote %s", filename))
--       end
--     end)
--   else
--     prof.start("*")
--   end
-- end
-- vim.keymap.set("", "<f1>", toggle_profile)
--

local function toggle_profile()
    if _G.__toggle_profile then
        vim.cmd("profile pause")
        vim.cmd("noautocmd qall!")
    else
        vim.cmd("TSContextDisable")
        vim.cmd("TSDisable highlight")
        vim.cmd("TSDisable indent")
        vim.cmd("profile start profile.log")
        vim.cmd("profile func *")
        vim.cmd("profile file *")
        _G.__toggle_profile = true
    end
end
vim.keymap.set("", "<f1>", toggle_profile)
