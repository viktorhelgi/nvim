
local cfg = {
    border = 'double',
	cmd = 'cmd', 
	hi = 'NormalFloat',
    dimensions  = {
        height = 0.8,
        width = 0.6,
    },
	ft = 'FTerm',
	blend = 20,
}


local fterm = require('FTerm')

fterm.setup(cfg)
-- local term = require("FTerm.terminal")

-- local term_inst = term:new()
-- term_inst:setup(cfg)

-- function _G.Fterm()
    -- term_inst:toggle()
-- end

local gitui = fterm:new({
    ft = 'fterm_gitui', -- You can also override the default filetype, if you want
    cmd = "gitui",
    dimensions = {
        height = 0.9,
        width = 0.9
    }
})

 -- Use this to toggle gitui in a floating terminal
function _G.__fterm_gitui()
    gitui:toggle()
end

 -- Use this to toggle gitui in a floating terminal
function _G._pipenv_update_PATH_and_VIRTUAL_ENV()
    local handle = io.popen("C:/Users/Lenovo/BATS/pipenv_check.bat")
    local result = handle:read("*l")
    -- vim.cmd("let g:my_pipenv=".."'".. result.."'")
    handle.close()

    local pipenv_path = string.sub(result,0, string.len(result)-1)

    local p       = os.getenv("PATH")
    local n_start = string.find(p,";")
    local n_end   = string.len(p)
    local subp =    string.sub(p, n_start, n_end)

    local new_path = table.concat({pipenv_path, subp})

    -- os.execute("set PATH="..new_path)
    vim.cmd("let $PATH='"..new_path.."'")
    vim.cmd("let $VIRTUAL_ENV='"..pipenv_path.."'")
    return new_path
end
function _G._update_pipenv()
    local handle = io.popen("C:/Users/Lenovo/BATS/pipenv_check.bat")
    local result = handle:read("*l")
    handle.close()
    local pipenv_path = result
    local path = pipenv_path .. ";" .. os.getenv("PATH")
end
