M = {}

---@class Location
---@field character number
---@field line number

---@class Range
---@field start Location
---@field end Location

---@class ImplItem
---@field originSelectionRange Range
---@field targetRange Range
---@field targetSelectionRange Range
---@field targetUri string
M._this = function()
	print("looo")
	return "what"
end

---@param range Range
---@param bufnr number
---@return string[]
local function get_text(range, bufnr)
	return vim.api.nvim_buf_get_text(
		bufnr,
		range.start.line,
		range.start.character,
		range["end"].line,
		range["end"].character,
		{}
	)
end

local Path = require("plenary.path")
local channel = require("plenary.async.control").channel
local async = require("plenary.async")

-- local function async_test()
-- 	local files = {
-- 		"/home/viktor/hm/research/route-guidance-analysis/bathymetry/src/main.rs",
-- 		"/home/viktor/hm/research/route-guidance-analysis/bathymetry/src/dog_able.r",
-- 		"/home/viktor/hm/research/route-guidance-analysis/shared/src/plot.rs",
-- 	}
--
-- 	print("------------------------------------------------------------------------")
-- 	---@type table
-- 	local outp = {}
--
-- 	local sender, receiver = channel.mpsc()
--
-- 	for i, f in ipairs(files) do
-- 		async.run(function()
-- 			---@type Path
-- 			local path = Path:new(f)
-- 			path:read(sender.send)
-- 		end)
-- 	end
-- 	-- vim.loop.sleep(1000)
--
-- 	local r_count = 0
-- 	while r_count < #files do
-- 		local data = receiver.recv()
-- 		print("lets")
-- 		table.insert(outp, data)
-- 		r_count = r_count + 1
-- 		print("received " .. r_count)
-- 	end
-- 	for index, value in ipairs(outp) do
-- 		print("-----")
-- 		print(index)
-- 		vim.pretty_print(value)
-- 	end
-- end
--
-- async.run(async_test)

---@class Implementation
---@field impls ImplStatement
---@field targetSelectionRange Range 

local utils = require("rust_funcs.utils")

---@class OutputItem
---@field ImplStatement

---@class MpscMessage
---@field item_number number
---@field impls ImplStatement|nil

---@param impl_items ImplItem[]
---@return Implementation[]|nil
M._process_data = function(impl_items)

    local sender, receiver = channel.mpsc()

    if 0 == #impl_items then
        return nil
    end

	local originSelectionRange = get_text(impl_items[1].originSelectionRange, 0)[1]

	for i, item in ipairs(impl_items) do

		async.run(function()

			---@type Path
			local path = Path:new(item.targetUri:sub(8, -1))

			path:read(function(file_content)  -- data is a string 

                local impls = utils.process_inputs(item, file_content, originSelectionRange)

                ---@type MpscMessage
                local message = {
                    item_number = i,
                    impls = impls
                }

                sender.send(message)

			end)
		end, function() end)  -- end of async-func
	end  -- end of for-loop


	---@type table<number, Implementation>
	local outp = {}

	for i = 1, #impl_items, 1 do

        ---@type MpscMessage
        local message = receiver.recv()

        if message.impls ~= nil then
            ---@class Implementation
            local outp_item = {
                impls = message.impls,
                targetSelectionRange = impl_items[i].targetSelectionRange
            }

            outp[message.item_number] = outp_item
        end
	end

	print("-----------------------------------------------------------------")
	print("done")
	for i, item in ipairs(outp) do
        if item ~= nil then
            print("Item: ".. i)
            local range = item.targetSelectionRange
            print("range: (".. range.start.line .. ", "..range['end'].line..")")
            local impls = item.impls
            if impls.impl_type == utils.IMPL_TYPE.derive then
                ---@type DeriveImplStatement
                local derive = impls.content
                print("derive: ")
                vim.pretty_print(derive)
            elseif impls.impl_type == utils.IMPL_TYPE.standard then
                ---@type StandardImplStatement
                local standard = impls.content
                print("standard: ")
                vim.pretty_print(standard.targetImplStatement)
            elseif impls.impl_type == utils.IMPL_TYPE.unknown then
                ---@type UnknownImplStatement
                local unknown_impl = impls.content
                print("unknown: "..unknown_impl.targetRange)
            end
	        print("-----------------------------------------------------------------")
        end
	end
	print("-----------------------------------------------------------------")
    return outp
end

-- print(vim.api.nvim_call_function(buf))
--
-- local osr_txt = get_text(item.originSelectionRange, buf)
-- -- local tsr_txt = get_text(item.targetSelectionRange, buf)
-- -- local tr_txt = get_text(item.targetRange, buf)
-- print("origin-selection-range")
-- vim.pretty_print(osr_txt)
-- -- print("target-selection-range")
-- vim.pretty_print(tsr_txt)
-- print("targett-range")
-- vim.pretty_print(tr_txt)
-- print("--")

---@class TDImplementationRespond
---@field result ImplItem[]


M.letsgo = function()
    ---@type TDImplementationRespond[]|nil
	local respond = vim.lsp.buf_request_sync(0, "textDocument/implementation", vim.lsp.util.make_position_params())
	-- local respond = vim.lsp.buf_request_sync(0, "textDocument/typeDefinition", vim.lsp.util.make_position_params())

	if respond == nil then
		print("error in func")
		return nil
	end

	-- local values = table.remove(respond, 1)["result"]
    local impl_items = respond[1].result
	if impl_items == nil then
		print("invalid respond")
		return nil
	end

	local implementations = M._process_data(impl_items)
end

-- local function letsgo(options)
-- 	local name = "textDocument/implementation"
-- 	local params = vim.lsp.util.make_position_params()
--
-- 	local req_handler
-- 	-- if options then
--     options = {}
--     req_handler = function(err, result, ctx, config)
--         local client = vim.lsp.get_client_by_id(ctx.client_id)
--         print("client")
--         -- vim.pretty_print(client)
--         local handler = client.handlers[name] or vim.lsp.handlers[name]
--         handler(err, result, ctx, vim.tbl_extend("force", config or {}, options))
--
--     end
-- 	-- end
--
--     local res, err = vim.lsp.buf_request(0, name, params, req_handler)
--     -- vim.lsp._cmd_parts
--
--     print("------------------------------------")
--     vim.pretty_print(res)
--     -- vim.pretty_print(err())
--     -- local res = err()
--
--
-- end
-- letsgo()
return M
