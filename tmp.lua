---@param error_number string
---@return string[]
local function rust_explain_contents(error_number)
	---@type string
	local shell_output = vim.api.nvim_exec2("!rustc --explain "..error_number, { output = true }).output

	---@type string[]
	local lines = vim.split(string.gsub(shell_output, "\n\n", "\n \n"), "\n")
	table.remove(lines, 1)
	return lines
end

local function get_max_line_width(lines)
    local max_width = 0

    ---@type string
    local line
    for _, line in pairs(lines) do
        if max_width < #line then
            max_width = #line
        end
    end
    return max_width
end

local function create_popup(error_number)
    local Popup = require("nui.popup")
    local event = require("nui.utils.autocmd").event

    local contents = rust_explain_contents(error_number)
    local width = get_max_line_width(contents)



    local popup = Popup({
        enter = true,
        focusable = true,
        win_options = {
            winhighlight = "Normal:Normal,FloatBorder:Normal",
        },
        border = {
            style = "rounded",
        },
        position = "50%",
        size = {
            width = width,
            height = "60%",
        },
    })

    popup:mount()
    popup:map("n", "q", "<CMD>q<CR>")

    -- unmount component when cursor leaves buffer
    popup:on(event.BufLeave, function()
        popup:unmount()
    end)

    vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, contents)
end

create_popup()

