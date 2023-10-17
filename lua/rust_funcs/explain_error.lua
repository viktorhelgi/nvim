local M = {}

---@param error_number string
---@return string[]
local function get_lines_from_rustc_explain_cmd(error_number)
	---@type string
	local shell_output = vim.api.nvim_exec2("!rustc --explain " .. error_number, { output = true }).output

	---@type string[]
	local lines = vim.split(string.gsub(shell_output, "\n\n", "\n \n"), "\n")
	table.remove(lines, 1)
    table.insert(lines, 1, "Error Code: "..error_number)
	return lines
end

---@param lines string[]
local function get_max_line_width(lines)
	local max_width = 0

	for _, line in pairs(lines) do
		if max_width < #line then
			max_width = #line
		end
	end
	return max_width
end

---@param error_number string
function M.open_popup(error_number)
	local Popup = require("nui.popup")
	local event = require("nui.utils.autocmd").event

	local contents = get_lines_from_rustc_explain_cmd(error_number)
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
    vim.api.nvim_buf_set_option(popup.bufnr, "modifiable", false)
end

M.windows = {}
local remove_buffer = function(bufnr)
	if bufnr > 0 and vim.api.nvim_buf_is_valid(bufnr) then
		local success, err = pcall(vim.api.nvim_buf_delete, bufnr, { force = true })
		if not success and err:match("E523") then
			vim.schedule_wrap(function()
				vim.api.nvim_buf_delete(bufnr, { force = true })
			end)()
		end
	end
end

---Determines if the window exists and is valid.
---@param state table The current state of the plugin for the given window.
---@return boolean True if the window exists and is valid, false otherwise.
local window_exists = function(state)
	local window_exists
	local winid = state.winid or 0
	local bufnr = state.bufnr or 0

	if winid < 1 then
		window_exists = false
	else
		window_exists = vim.api.nvim_win_is_valid(winid)
			and vim.api.nvim_win_get_number(winid) > 0
			and vim.api.nvim_win_get_buf(winid) == bufnr
	end

	if not window_exists then
		remove_buffer(bufnr)
		state.winid = nil
		state.bufnr = nil
	end
	return window_exists
end

---@class Err
local Err = {
    NoDiags = "No diagnostics to show for this line"
}


---@param err string
local function handle_error (err, state)
	local source_win = vim.api.nvim_get_current_win()
	local _window_exists = window_exists(state)
    if _window_exists then
        vim.api.nvim_win_close(state.winid, true)
        remove_buffer(state.bufnr)
        M.windows[source_win] = nil
    end
	print(err)
	vim.notify(err)

end

M.open_popup_here = function()
	local source_win = vim.api.nvim_get_current_win()
	M.windows[source_win] = M.windows[source_win] or {}
	local state = M.windows[source_win]

	local loc = vim.api.nvim_win_get_cursor(0)
    local line_num = loc[1] - 1
    -- local col_num = loc[1] - 1

	local diag = vim.diagnostic.get(0, { lnum = line_num,  })
    local it = 1

    while it <= #diag do
        local code = diag[it].code
        if code==nil then
            it = it + 1
        else
            local first_letter = string.sub(code, 0, 1)
            if first_letter=="E" then
                it = it + 1
            else
                table.remove(diag, it)
            end
        end
    end

	if #diag == 0 then
		handle_error(Err.NoDiags, state)
        return
	end

    local d = diag[1]

    M.open_popup(d.code)
end

M.print_error_as_json = function()
	local source_win = vim.api.nvim_get_current_win()
	M.windows[source_win] = M.windows[source_win] or {}
	local state = M.windows[source_win]

	local loc = vim.api.nvim_win_get_cursor(0)
    local line_num = loc[1] - 1
    local col_num = loc[1] - 1


	local diag = vim.diagnostic.get(0, { lnum = line_num,  })
	if #diag == 0 then
		handle_error(Err.NoDiags, state)
	end

    local d = diag[1]

    vim.print(d)
end


-- { {
--     bufnr = 7,
--     code = "E0391",
--     col = 4,
--     end_col = 19,
--     end_lnum = 38,
--     lnum = 38,
--     message = "cycle used when computing explicit predicates of `pathfinding::a_star::third_impl::algorithm::algorithm3`",
--     namespace = 38,
--     severity = 4,
--     source = "rustc",
--     user_data = {
--       lsp = {
--         code = "E0391",
--         codeDescription = {
--           href = "https://doc.rust-lang.org/error-index.html#E0391"
--         },
--         relatedInformation = { {
--             location = {
--               range = {
--                 ["end"] = {
--                   character = 40,
--                   line = 39
--                 },
--                 start = {
--                   character = 25,
--                   line = 39
--                 }
--               },
--               uri = "file:///home/viktorhg/hm/route-guidance/src/pathfinding/a_star/third_impl/algorithm.rs"
--             },
--             message = "original diagnostic"
--           } }
--       }
--     }
--   } }



return M
