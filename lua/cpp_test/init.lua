M = {
	_last_cmd = nil,
}

local tmux = require('harpoon.tmux')

local function file_exists(name)
	local f = io.open(name, 'r')
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

-- https://stackoverflow.com/a/20460403
local function findLast(haystack, needle)
	local i = haystack:match('.*' .. needle .. '()')
	if i == nil then
		return nil
	else
		return i - 1
	end
end

local function parent_dir(dir)
	return dir:sub(1, findLast(dir, '/') - 1)
end

local term_pattern = parent_dir(os.getenv('HOME'))

local function find_root(path, patterns)
	if type(path) ~= 'string' then
		error('path argument in rooter.find_root_dir() should be a string')
	elseif type(patterns) ~= 'table' then
		error('path argument in rooter.find_root_dir() should be a string')
	elseif #patterns == 0 then
		error("'patterns' argument is of len 0")
	end

	while path ~= term_pattern do
		for _, dir in ipairs(patterns) do
			if file_exists(path .. '/' .. dir) then
				return path
			end
		end
		path = parent_dir(path)
	end

	error('No-match: \npath: ' .. path)
end

local function get_root_directory(file)
	local file_abs = vim.fn.expand(file .. ':p')
	local dot_root_path = vim.fn.finddir('build', file_abs .. ';')
	return vim.fn.fnamemodify(dot_root_path, ':p:h')
end
M.get_relative_path_to_file = function(file)
	local dot_file_path = vim.fn.expand(file)
	return vim.fn.fnamemodify(dot_file_path, '%:~:.:h')
end
local function get_relative_path_to_directory(file)
	local dot_file_path = vim.fn.expand(file .. ':h')
	return vim.fn.fnamemodify(dot_file_path, '%:~:.:p')
end

local function exists(name)
	if type(name) ~= 'string' then
		return false
	end
	return os.rename(name, name) and true or false
end

local function isFile(name)
	if type(name) ~= 'string' then
		return false
	end
	if not exists(name) then
		return false
	end
	local f = io.open(name)
	if f then
		f:close()
		return true
	end
	return false
end

M.get_parent_folder = function(file)
	local dot_file_path = vim.fn.expand(file .. ':h:t')
	return vim.fn.fnamemodify(dot_file_path, '%:p:p')
end
M.get_parent_parent_folder = function(file)
	-- local dot_file_path = vim.fn.expand(file..":p:h:h:t")
	return vim.fn.fnamemodify(file, ':p:h:t')
end

M.string_contains = function(outer, inner)
	return outer:match('%f[%a]' .. inner .. '%f[%A]') ~= nil
end

local function is_test_file(filename)
	return string.sub(filename, 0, 4) == 'test'
end

local function get_exe_name_folder(file)
	local exe1 = vim.fn.expand(file .. ':t:r')
	if not is_test_file(exe1) then
		error('\nERROR: Not a test file')
	end
	-- local parent_folder = _G.get_parent_parent_folder(file)
	-- local parent_folder = vim.fn.expand(file..":h:t")
	local parent_folder = string.gsub(vim.fn.expand(file .. ':h:t'), '-', '_')
	local exe2 = 'test_' .. parent_folder .. '_' .. string.sub(exe1, 6, -1)

	local relative_path = get_relative_path_to_directory(file)
	-- local relative_path = vim.fn.fnamemodify(vim.fn.expand(file..":h"), 'p:~:.')
	local root_dir = get_root_directory(file)

	local cwd = vim.fn.getcwd()
	local build_dir = root_dir .. '/build'

	if string.len(root_dir) ~= string.len(cwd) then
		local sub_folder = string.sub(cwd, string.len(root_dir) + 1, -1)
		build_dir = build_dir .. sub_folder
	end

	local exe_dir_abs_path = build_dir .. '/' .. relative_path .. '/'

	local exe1_abs_path = exe_dir_abs_path .. '/' .. exe1
	local exe2_abs_path = exe_dir_abs_path .. '/' .. exe2

	if isFile(exe1_abs_path) then
		return vim.fn.fnamemodify(exe1_abs_path, ':h')
	elseif isFile(exe2_abs_path) then
		return vim.fn.fnamemodify(exe2_abs_path, ':h')
	else
		error('No Executable found\n' .. exe1_abs_path .. '\n' .. exe2_abs_path)
	end
end

-- local path = "/tests/alerts/test_config.cpp"
-- local file = vim.fn.fnamemodify(path, ":t")
-- print("file: "..file)

local function get_exe_name(file)
	local root_dir = find_root(file, { 'build' })
	local relative_path = string.gsub(file, root_dir, '')
	vim.print('file:          ' .. file)
	vim.print('relative_path: ' .. relative_path)
	local exe_filename = vim.fn.fnamemodify(relative_path, ':t')
	vim.print('exe_name       ' .. exe_filename)

	local build_dir = root_dir .. '/build'

	local exe_path = build_dir .. vim.fn.fnamemodify(relative_path, ':r')

	if vim.fn.exists(exe_path) then
		return exe_path
	else
		error("file doesn't exists...........")
	end
end
-- local test_file = "/home/viktorhg/hm/embedded/frontpub/tests/alerts/test_config.cpp"
-- local test_output = get_exe_name(test_file)
--
-- print("in:  "..test_file)
-- print("out: "..test_output)

-- local test_file = "/home/viktorhg/hm/embedded/frontpub/build/tests/test_alerts_configg"
-- if vim.fn.exists(test_file) then
--     print("exists")
-- else
--     print("doesn't exists")
-- end

-- 	-- local exe1 = vim.fn.expand(file .. ":t:r")
-- 	-- if not is_test_file(exe1) then
-- 	--     error("\nERROR: Not a test file")
-- 	-- end
-- 	-- -- local parent_folder = _G.get_parent_parent_folder(file)
-- 	-- local parent_folder = string.gsub(vim.fn.expand(file .. ":h:t"), "-", "_")
-- 	-- local exe2 = "test_" .. parent_folder .. "_" .. string.sub(exe1, 6, -1)
-- 	--
-- 	--
-- 	-- local relative_path = get_relative_path_to_directory(file)
-- 	-- local root_dir = get_root_directory(file)
-- 	--
-- 	--
-- 	-- local cwd = vim.fn.getcwd()
-- 	-- local build_dir = root_dir .. "/build"
-- 	--
-- 	--
-- 	-- if (string.len(root_dir) ~= string.len(cwd)) then
-- 	--     local sub_folder = string.sub(cwd, string.len(root_dir) + 1, -1)
-- 	--     build_dir = build_dir .. sub_folder
-- 	-- end
-- 	--
-- 	-- local exe_dir_abs_path = build_dir .. "/" .. relative_path
-- 	--
-- 	-- print("exe dir : "..exe_dir_abs_path)
-- 	-- local exe1_abs_path = exe_dir_abs_path .. "/" .. exe1
-- 	-- local exe2_abs_path = exe_dir_abs_path .. "/" .. exe2
-- 	--
-- 	--
-- 	-- if (isFile(exe1_abs_path)) then
-- 	--     return exe1
-- 	-- elseif (isFile(exe2_abs_path)) then
-- 	--     return exe2
-- 	-- else
-- 	--     error("No Executable found\n" .. exe1_abs_path .. "\n" .. exe2_abs_path)
-- 	-- end
-- end

M.run_test = function(file, with_valgrind)
	-- local relative_path = get_relative_path_to_directory(file)

	local harpoon = require('harpoon.term')
	local cr = '\r'

	-- filename without extension
	local exe_path, exe_folder, status

	status, exe_path = pcall(get_exe_name, file)
	if not status then
		print('error calling get_exe_name')
		print(exe_path)
		return 0
	end

	local root_dir = find_root(file, { 'build' })
	local build_dir = root_dir .. '/build'

	local relative_path = string.gsub(file, root_dir, '')

	local exe_dir = build_dir .. vim.fn.fnamemodify(relative_path, ':h')

	-- print("------------------")
	-- print(exe_dir)
	-- print(vim.fn.exists(exe_dir))
	if vim.fn.exists(exe_dir) == 0 then
		-- print("lets go")
		local tmp = build_dir .. '/tests/'
		-- print(tmp)
		if vim.fn.exists(tmp) then
			exe_dir = tmp
		end
	end

	local exe_name = vim.fn.fnamemodify(exe_path, ':t')

	-- run test
	-- vim.cmd('winc l')
	-- harpoon.gotoTerminal(1)
	require('harpoon.tmux').sendCommand('!', cr)
	require('harpoon.tmux').sendCommand(
		'!',
		'echo && echo =================================== && echo - Configure Tests && echo --- '
			.. exe_path
			.. ' && echo =================================== && echo '
			.. '&& cd '
			.. build_dir
			.. ' && cd '
			.. exe_dir
			.. '&& make '
			.. exe_name
			.. '&& ./'
			.. exe_name
			.. ' && '
			.. 'cd '
			.. root_dir
			.. cr
	)

	print('Test Executed: ' .. exe_name)
end

M.run_test2 = function(file)
	-- local path = '/tests/alerts/test_config.cpp'
	print(file)
	local n = vim.fn.fnamemodify(file, ':t')
	-- print(n)  -- test_config.cpp
	local look_up = string.find(file, 'test_', 1)

	if look_up ~= nil then
		n = string.sub(n, 6, -1)
	end
	-- print(n)  -- config.cpp
	local look_up_dot = string.find(n, '.[ch]pp', 1)
	if look_up_dot ~= nil then
		n = string.sub(n, 0, look_up_dot - 1)
	end
	-- print(n) -- config

	print(n)
	local exe_relative_paths_found = vim.fs.find(function(name, path)
		return name:match('test_.*' .. n .. '$')
	end, { limit = 3, type = 'file', path = 'build' })

	if table.getn(exe_relative_paths_found) > 1 then
		print('matches found: ')
		vim.pretty_print(exe_relative_paths_found)
	elseif #exe_relative_paths_found == 0 then
		print('NO matches found')
		return
	end

	local exe_relative_path = exe_relative_paths_found[1]
	print('executing test: ' .. exe_relative_path)

	local root_dir = find_root(file, { 'build' })
	-- local exe_dir = build_dir .. vim.fn.fnamemodify(exe_relative_path, ':h')
	local exe_name = vim.fn.fnamemodify(exe_relative_path, ':t')

	M._last_cmd = 'echo '
		.. '&& echo '
		.. '&& echo =================================== '
		.. '&& echo - Configure Tests '
		.. '&& echo --- '
		.. exe_relative_path
		.. ' '
		.. '&& echo =================================== '
		.. '&& cd '
		.. vim.fn.fnamemodify(exe_relative_path, ':p:h')
		.. ' '
		.. '&& make '
		.. exe_name
		.. ' '
		.. '&& ./'
		.. exe_name
		.. ' '
		.. '&& cd '
		.. root_dir
		.. '\r'
	tmux.sendCommand('1', '^c')
	tmux.sendCommand('!', M._last_cmd)
end

M.run_last = function()
    if M._last_cmd ~= nil then
        tmux.sendCommand('1', '^c')
        tmux.sendCommand('!', M._last_cmd)
    else
        print("No command has been executed")
    end
end

-- M.run_test2('/home/viktorhg/hm/embedded/frontpub/tests/alerts/test_config.cpp')

-- M.run_test("/home/viktor/hm/fogeval/tests/fogeval/neural_network/test_model.cpp")

return M
