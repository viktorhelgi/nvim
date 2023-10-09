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


-- vim.cmd [[
--   augroup strdr4605
--     autocmd FileType typescript,typescriptreact compiler tsc | setlocal makeprg=npx\ tsc
--   augroup END
-- ]]

-- local augroup = vim.api.nvim_create_augroup("strdr4605", { clear = true })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "typescript,typescriptreact",
--   group = augroup,
--   command = "compiler tsc | setlocal makeprg=npx\\ tsc",
-- })
-- vim.cmd [[
--   augroup strdr4605
--     autocmd FileType typescript,typescriptreact set makeprg=./node_modules/.bin/tsc\ \\\|\ sed\ 's/(\\(.*\\),\\(.*\\)):/:\\1:\\2:/'
--   augroup END
-- ]]
--

-- vim.cmd('set makeprg=npm\\ start\\ --port\\ 3000')
-- vim.cmd[[
--     compiler tsc
--     " set makeprg=./node_modules/.bin/tsc\ \\\|\ sed\ 's/(\\(.*\\),\\(.*\\)):/:\\1:\\2:/'
--     " set efm=%-P%f,
--     "         \%E%>\ #%n\ %m,%Z%.%#Line\ %l\\,\ Pos\ %c,
--     "                     \%-G%f\ is\ OK.,%-Q
-- ]]


vim.cmd([[
    let g:vimspector_sidebar_width = 85
    let g:vimspector_bottombar_height = 15
    let g:vimspector_terminal_maxwidth = 70
]])

vim.cmd([[
    nmap <F9> <cmd>call vimspector#Launch()<cr>
    nmap <F5> <cmd>call vimspector#StepOver()<cr>
    nmap <F8> <cmd>call vimspector#Reset()<cr>
    nmap <F11> <cmd>call vimspector#StepOver()<cr>")
    nmap <F12> <cmd>call vimspector#StepOut()<cr>")
    nmap <F10> <cmd>call vimspector#StepInto()<cr>")
]])

vim.keymap.set("n", "<leader>Db", ":call vimspector#ToggleBreakpoint()<cr>")
vim.keymap.set("n", "<leader>Dw", ":call vimspector#AddWatch()<cr>")
vim.keymap.set("n", "<leader>De", ":call vimspector#Evaluate()<cr>")

local regular_string = [[
lorem impsum 
some frog and a red fox
lets go
]]

local query_template = [[
;; letsgoman
((function_call
  name: [
    (identifier) @_cdef_identifier
    (_ _ (identifier) @_cdef_identifier)
  ]
  arguments: (arguments (string content: _ @c)))
  (#eq? @_cdef_identifier "cdef"))

((function_call
  name: (_) @_vimcmd_identifier
  arguments: (arguments . (string content: _ @vim)))
  (#any-of? @_vimcmd_identifier "vim.cmd" "vim.api.nvim_command" "vim.api.nvim_exec" "vim.api.nvim_exec2"))
]]

local query_templat = [[
;; rust 
]]

-- ```
-- #[derive(Error, Debug)]
-- pub enum ServerError {
--     #[error("")]
--     ClientInitialization(#[from] GCloudBucketError),
--
--     #[error("")]
--     DownloadMetadata(#[from] metadata::DownloadError),
-- }
-- ```
-- `
