_G.cmake_errorformat = ' %#%f:%l %#(%m)' .. ',%E' .. 'CMake Error at %f:%l (%m):'..',%Z'..'Call Stack (most recent call first):'..',%C'..' %m'
_G.set_qflist_what = '"efm":"'.._G.cmake_errorformat..'"'
_G.set_qflist_what = _G.set_qflist_what .. ', "title":"cmake-build"'
-- _G.cmake_errorformat .= 
-- let &efm .= ',%Z' . 'Call Stack (most recent call first):'
-- _G.cmake_errorformat .= ',%E' .. 'CMake Error at %f:%l (%m):'
-- 
-- ',%Z' . 'Call Stack (most recent call first):'
-- ',%C' . ' %m'

_G.get_relative_dir = function(file)
    -- local project_dir = "/home/viktor/hm/MK2-embedded/device/wbv/"
    local project_dir = require('viktor.lib.find').root(file, {"build"})
    if type(file)=='string' then
        local curr_dir = vim.fn.fnamemodify(file, ":p:h")
        local curr_dir_rel = string.sub(curr_dir, string.len(project_dir)+1, -1)
        return curr_dir_rel
    end
    error("input to get_binary_dir is not a string")
end

_G.build_file = function(file)
    -- local project_dir = "/home/viktor/hm/MK2-embedded/device/wbv/"
    local project_dir = require('viktor.lib.find').root(file, {"build"})
    local rel_dir = get_relative_dir(file)
    local bin_dir = project_dir .. "/build" .. rel_dir

    local cr = "\r"
    local clear = "clear -x"..cr
    local goto_dir = 'cd '..bin_dir..cr
    local run_make = "make -j17"..cr
    require('harpoon.tmux').sendCommand('!', cr..clear..goto_dir..run_make)
end

_G.clear_build = function(file)
    -- local project_dir = "/home/viktor/hm/MK2-embedded/device/wbv/"
    local project_dir = require('viktor.lib.find').root(file, {"build"})
    local bin_dir = project_dir .. "/build"

    local cr = "\r"
    local goto_dir = 'cd '..bin_dir..cr
    local remove_build = "remb"..cr
    require('harpoon.tmux').sendCommand('!', cr..goto_dir..cr..remove_build)
end

_G.build_configure_left = function(file)
    -- local project_dir = "/home/viktor/hm/MK2-embedded/device/wbv/"
    local project_dir = require('viktor.lib.find').root(file, {"build"})
    local rel_dir = get_relative_dir(file)
    local bin_dir = project_dir .. "/build"

    local cr = "\r"
    local clear = "clear -x"..cr
    local goto_dir = 'cd '..bin_dir..cr
    local run_make = "cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .."..cr
    vim.api.nvim_set_var("_previous_command", cr..clear..goto_dir..run_make)
    require('harpoon.tmux').sendCommand('!', vim.g._previous_command)
end

_G.run_make_left = function(file)
    -- local project_dir = "/home/viktor/hm/MK2-embedded/device/wbv/"
    local project_dir = require('viktor.lib.find').root(file, {"build"})
    local rel_dir = get_relative_dir(file)
    local bin_dir = project_dir .. "/build"

    local cr = "\r"
    local clear = "clear -x"..cr
    local goto_dir = 'cd '..bin_dir..cr
    local run_make = "make -j17"..cr
    vim.api.nvim_set_var("_previous_command", cr..clear..goto_dir..run_make)
    require('harpoon.tmux').sendCommand('!', vim.g._previous_command)
end


_G.run_again = function()
    local command = vim.api.nvim_get_var("_previous_command")
    print(command)
    require('harpoon.tmux').sendCommand('!', command)
end

_G.run_make_left_and_run = function(file)
    -- local project_dir = "/home/viktor/hm/MK2-embedded/device/wbv/"
    local project_dir = require('viktor.lib.find').root(file, {"build"})
    local rel_dir = get_relative_dir(file)
    local bin_dir = project_dir .. "/build"

    local exe_directory = bin_dir..rel_dir


    local parent_dir = vim.fn.fnamemodify(file, ":p:h:t")
    local filename = vim.fn.fnamemodify(file, ":t:r")

    local filename_without_test_prefix = string.sub(filename, string.len("test_"), string.len(filename))
    local filename_potential = "test_"..parent_dir..filename_without_test_prefix

    local exe_name
    if (vim.fn.executable(exe_directory .. "/" .. filename) == 1) then
        print("tsahtnh")
        exe_name = filename
    elseif (vim.fn.executable(exe_directory .. "/" .. filename_potential) == 1) then
        print("letsgo")
        exe_name = filename_potential
    end

    local cr = "\r"
    local clear = "clear -x"..cr
    local goto_dir = 'cd '..exe_directory..cr
    local run_make = "make -j17"..cr
    local run_exe  = "./"..exe_name.. cr
    require('harpoon.tmux').sendCommand('!', cr..clear..goto_dir..run_make..run_exe)
end

_G.run_file_left = function(file)
    -- local project_dir = "/home/viktor/hm/MK2-embedded/device/wbv/"
    local project_dir = require('viktor.lib.find').root(file, {"build"})
    local rel_dir = get_relative_dir(file)
    local bin_dir = project_dir .. "/build" .. rel_dir

    local cr = "\r"
    local clear = "clear -x"..cr
    local goto_dir = 'cd '..bin_dir..cr
    -- local run_make = "make"..cr
    local run_exe  = "./"..vim.fn.fnamemodify(file, ":t:r") .. cr
    require('harpoon.tmux').sendCommand('!', cr..clear..goto_dir..run_exe)
end

_G.run_plot = function(file)
    -- local project_dir = "/home/viktor/hm/MK2-embedded/device/wbv/"
    local project_dir = require('viktor.lib.find').root(file, {"build"})
    local rel_dir = get_relative_dir(file)
    local bin_dir = project_dir .. "/build" .. rel_dir
    local filename = vim.fn.fnamemodify(file, ":t:r")

    local cr = "\r"
    -- local run_make = "make"..cr

    local file_path = bin_dir .. "/" .. filename

    local other_file_path = project_dir .. "/build" .. string.gsub(rel_dir, "include", "tests") .. "/test_".. filename

    if (vim.fn.file_readable(file_path) == 1) then
        local clear = "clear -x"..cr
        local goto_dir = 'cd '..bin_dir..cr
        local run_exe  = "./"..filename.. cr
        require('harpoon.tmux').sendCommand('!', cr..clear..goto_dir..run_exe)
    elseif (vim.fn.file_readable(other_file_path) == 1) then
        local clear = "clear -x"..cr
        local goto_dir = 'cd '..project_dir .. "/build" .. string.gsub(rel_dir, "include", "tests")..cr
        local run_exe  = "./test_"..filename.. cr
        require('harpoon.tmux').sendCommand('!', cr..clear..goto_dir..run_exe)
    end
end

_G.make_file_right = function(file)
    -- local project_dir = "/home/viktor/hm/MK2-embedded/device/wbv/"
    local project_dir = require('viktor.lib.find').root(file, {"build"})
    local rel_dir = get_relative_dir(file)
    local bin_dir = project_dir .. "/build" .. rel_dir
    local filename = vim.fn.fnamemodify(file, ":t:r")

    local cr = "\r"
    -- local run_make = "make"..cr

    local file_path = bin_dir .. "/" .. filename

    local other_file_path = project_dir .. "/build" .. string.gsub(rel_dir, "include", "tests") .. "/test_".. filename
    if (vim.fn.file_readable(file_path) == 1) then
        local clear = "clear -x"..cr
        local goto_dir = 'cd '..bin_dir..cr
        local make_file = "make -j17 "..filename..cr
        local run_exe  = "./"..filename.. cr
        require('harpoon.tmux').sendCommand('!', cr..clear..goto_dir..make_file..run_exe)
    elseif (vim.fn.file_readable(other_file_path) == 1) then
        local clear = "clear -x"..cr
        local goto_dir = 'cd '..project_dir .. "/build" .. string.gsub(rel_dir, "include", "tests")..cr
        local test_filename = "./test_"..filename
        local make_file = "make -j17 "..test_filename..cr
        local run_exe  = test_filename.. cr
        require('harpoon.tmux').sendCommand('!', cr..clear..goto_dir..make_file..run_exe)
    end
end

_G.run_file_here = function(file)
    local project_dir = require('viktor.lib.find').root(file, {"build"})
    local rel_dir = get_relative_dir(file)
    local bin_dir = project_dir .. "/build" .. rel_dir

    local goto_dir = 'cd '..bin_dir
    -- local run_make = "make"..cr
    local run_exe  = "./"..vim.fn.fnamemodify(file, ":t:r")
    vim.cmd('set errorformat=%f:%l:%c:%trror:%m,%f:%l:%c:%twarning:%m,%f:%l:%c:%tnote:%m')
    vim.cmd('redir @h')
    vim.cmd('silent !'..goto_dir.."&&"..run_exe.. "&&echo Done")
    vim.cmd('redir END')
    -- local inp = ''
    -- vim.cmd("call setqflist(map(split(@h, '\\n'),{\'filename\': v:val }))")
    vim.cmd("echo map(split(@h, '\\|\\n'),'{\"filename\": v:val})")
    -- vim.cmd("call setqflist(map(split(@h, '\\|\\n'),'{\"filename\": v:val}), ".._G.set_qflist_what.."}'))")
end

_G.build_file_in_nvim = function(file)
    local project_dir = require('viktor.lib.find').root(file, {"build"})
    local rel_dir = get_relative_dir(file)
    -- vim.cmd('cd '..project_dir..'&& make -s -C build/'..rel_dir)
    -- vim.cmd('make -s -C build/'..rel_dir)

    vim.cmd('redir @h')
    vim.cmd('silent! exec "cd '..project_dir..'&& !make -j17 -s -C build/ && echo Done'..rel_dir..'"')
    vim.cmd('redir END')

    local lines_buffer = vim.fn.getreg("h")
    local lines = {};
    local delimiter ="\n"
    for match in (lines_buffer..delimiter):gmatch("(.-)"..delimiter) do
        if string.match(match, ":!cd build*.")==nil then
            if string.len(match)>0 then
                table.insert(lines, match)
            end
        end
    end
    local errorformat = {
        "%IDone",
        "%ECMake Error at %f:%l\\ %m:",
        "%C  Target %o",
        "%Z  %m",
        "%I  %f:%l %m",
        "%-G\\s%#",
    }
    vim.fn.setqflist({},'r', {lines=lines, title="make", efm=table.concat(errorformat, ",")})
end

_G.new_run_test_file = function(file)
    local project_dir = require('viktor.lib.find').root(file, {"build"})
    local rel_dir = get_relative_dir(file)
    local filename  = "./" .. vim.fn.fnamemodify(file, ":t:r")
    -- local filename = "ctest"
    local bin_dir = project_dir .. "/build" .. rel_dir


    vim.cmd('redir @h')
    vim.cmd('silent! exec "cd '..bin_dir..'"')
    vim.cmd('silent! exec "!'..filename..'"')
    -- vim.cmd('silent! exec "cd '..bin_dir..' && !'..filename..'"')
    -- vim.cmd('silent! exec "ls"')
    -- vim.cmd('silent! exec "make -j17 '..filename..'"')
    -- vim.cmd('silent! exec "./'..filename..'"')
-- ..cr..'!make -j17 -s '..filename..cr.."./"..filename..cr..' echo Done'..rel_dir..'"
    vim.cmd('redir END')

    local lines_buffer = vim.fn.getreg("h")
    local lines = {};
    local delimiter ="\n"
    for match in (lines_buffer..delimiter):gmatch("(.-)"..delimiter) do
        if string.match(match, ":!cd build*.")==nil then
            if string.len(match)>0 then
                table.insert(lines, match)
            end
        end
    end
    local errorformat = {
        "%E%f:%l: %m",
        "%-G\\s%#",
    }
    vim.fn.setqflist({},'r', {lines=lines, title="make"})
end


_G.run_make_in_nvim = function(file)
    local project_dir = require('viktor.lib.find').root(file, {"build"})

    vim.cmd('redir @h')
    vim.cmd('silent! exec "cd '..project_dir..'/build"')
    vim.cmd('silent! exec "!make -j17"')
    vim.cmd('redir END')

    local lines_buffer = vim.fn.getreg("h")
    local lines = {};
    local delimiter ="\n"
    for match in (lines_buffer..delimiter):gmatch("(.-)"..delimiter) do
        if string.match(match, ":!cd build*.")==nil then
            if string.len(match)>0 then
                table.insert(lines, match)
            end
        end
    end
    local errorformat = {
        "%IDone",
        "%-G:!make%.%#",
        "%-G[%o] Built target %.%#",
        "%-G[%o] Building CXX %.%#",
        "%-Gcompilation terminated.",
        "%-Gmake%.%#",
        "%E%f:%l:%c: fatal error: %m", -- {%.n<.20}%m",
        "%E%f:%l:%c: error: %m", -- {%.n<.20}%m",
        -- "|"
        -- "%E%f:%l:%c: fa%.%#: %m", -- {%.n<.20}%m",
        "%-G %.%# | %.%#",
        -- "%C%f:%l:%c: error: %m",
        "%.%#Built target %o",
        --[[ "%I%\\*%.: %o ‘%m‘",
        "%> error: %m",
        "%C%.%#|%m ",
        "[ %*\\d\\%] Built target %m"
        "%o"
        "%Z  %m",
        "%I  %f:%l %m",
        "%-G\\s%#", ]]
    }
    vim.fn.setqflist({},'r', {lines=lines, title="make", efm=table.concat(errorformat, ",")})
    -- vim.fn.setqflist({},'r', {lines=lines, title="make"})
    -- || /home/viktor/hm/research/wbv-analysis/external/MK2-embedded/device/wbv/include/wbv_mqtt/messages.cpp: In constructor ‘wbv::ImuMessage::Payload::Payload(void*)’:
    -- || /home/viktor/hm/research/wbv-analysis/external/MK2-embedded/device/wbv/include/wbv_mqtt/messages.cpp:34:5: error: ‘cat’ was not declared in this scope; did you mean ‘dat’?
    -- ||    34 |     cat.at("acc_z").get_to(this->z);
    -- ||       |     ^~~
    -- ||       |     dat
    --
    -- tests/metrics/test_calculate_vibration_metrics.cpp|10 col 10| fatal error: testlib/file_reader.hpp: No such file or directory
    -- ||    10 | #include "testlib/file_reader.hpp"
    -- ||       |          ^~~~~~~~~~~~~~~~~~~~~~~~~
end

_G.run_cmake_in_nvim = function(file)
    local project_dir = require('viktor.lib.find').root(file, {"build"})

    vim.cmd('redir @h')
    vim.cmd('silent! exec "cd '..project_dir..'/build"')
    vim.cmd('silent! exec "!cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .."')
    vim.cmd('redir END')

    local lines_buffer = vim.fn.getreg("h")
    local lines = {};
    local delimiter ="\n"
    for match in (lines_buffer..delimiter):gmatch("(.-)"..delimiter) do
        if string.match(match, ":!cd build*.")==nil then
            if string.len(match)>0 then
                table.insert(lines, match)
            end
        end
    end
    local errorformat = {
        -- "%IDone",
        -- "%ECMake Error at %f:%l\\ %m:",
        -- "%C  Target %o",
        -- "%Z  %m",
        -- "%I  %f:%l %m",
        -- "%-G\\s%#",

        "%IDone",
        "%-G:!make%.%#",
        "%-G[%o] Built target %.%#",
        "%-G[%o] Building CXX %.%#",
        "%-Gcompilation terminated.",
        "%-Gmake%.%#",
        "%E%f:%l:%c: fatal error: %m", -- {%.n<.20}%m",
        "%ECMake Error at %f:%l\\ %m:",
        "%C  Target %o",
        "%Z  %m",
        "%I  %f:%l %m",
        "%-G\\s%#",
        -- "|"
        -- "%E%f:%l:%c: fa%.%#: %m", -- {%.n<.20}%m",
        "%-G %.%# | %.%#",
        -- "%C%f:%l:%c: error: %m",
        "%.%#Built target %o",
        --[[ "%I%\\*%.: %o ‘%m‘",
        "%> error: %m",
        "%C%.%#|%m ",
        "[ %*\\d\\%] Built target %m"
        "%o"
        "%Z  %m",
        "%I  %f:%l %m",
        "%-G\\s%#", ]]
    }
    vim.fn.setqflist({},'r', {lines=lines, title="make", efm=table.concat(errorformat, ",")})
    -- vim.fn.setqflist({},'r', {lines=lines, title="make"})
    -- || /home/viktor/hm/research/wbv-analysis/external/MK2-embedded/device/wbv/include/wbv_mqtt/messages.cpp: In constructor ‘wbv::ImuMessage::Payload::Payload(void*)’:
    -- || /home/viktor/hm/research/wbv-analysis/external/MK2-embedded/device/wbv/include/wbv_mqtt/messages.cpp:34:5: error: ‘cat’ was not declared in this scope; did you mean ‘dat’?
    -- ||    34 |     cat.at("acc_z").get_to(this->z);
    -- ||       |     ^~~
    -- ||       |     dat
    --
    -- tests/metrics/test_calculate_vibration_metrics.cpp|10 col 10| fatal error: testlib/file_reader.hpp: No such file or directory
    -- ||    10 | #include "testlib/file_reader.hpp"
    -- ||       |          ^~~~~~~~~~~~~~~~~~~~~~~~~
end
-- || :!make -s -C build/
-- || [ 89%] Built target fftw3
-- || [ 91%] Built target fftw3_omp
-- || [ 91%] Built target fftw++
-- || [ 92%] Built target ttime
-- || [ 93%] Built target mqtt
-- || [ 93%] Built target wbv__commons
-- || [ 94%] Built target wbv__fourier
-- || [ 95%] Built target wbv__freq_weight_accs
-- || [ 96%] Built target wbv__metrics_private
-- || [ 96%] Built target wbv__metrics
-- || [ 97%] Built target wbv_mqtt
-- || [ 97%] Built target wbv
-- || [ 97%] Built target test_frequency_spectrum
-- || [ 98%] Built target test_sampling
-- || [ 98%] Built target test_transform
-- || [ 99%] Built target test_evaluate
-- || [100%] Built target test__index_of_upper_bound
-- || [100%] Built target test_dimensions
-- || [100%] Building CXX object tests/metrics/CMakeFiles/test_calculate_vibration_metrics.dir/test_calculate_vibration_metrics.cpp.o
-- tests/metrics/test_calculate_vibration_metrics.cpp|10 col 10| fatal error: testlib/file_reader.hpp: No such file or directory
-- ||    10 | #include "testlib/file_reader.hpp"
-- ||       |          ^~~~~~~~~~~~~~~~~~~~~~~~~
-- || compilation terminated.
-- make[2]: *** [tests/metrics/CMakeFiles/test_calculate_vibration_metrics.dir/build.make|76| tests/metrics/CMakeFiles/test_calculate_vibration_metrics.dir/test_calculate_vibration_metrics.cpp.o] Error 1

vim.keymap.set('n', '<leader>bb', '<cmd>w<cr><cmd>so %<cr><cmd>lua _G.build_all_in_nvim(vim.fn.expand("%:p"))<CR><CMD>copen<CR>')
_G.run_xxx_in_nvim = function(cmd)
    vim.cmd('redir @h')
    vim.cmd('silent! exec "!'..cmd..'"')
    vim.cmd('redir END')

    local lines_buffer = vim.fn.getreg("h")
    local lines = {};
    local delimiter ="\n"
    for match in (lines_buffer..delimiter):gmatch("(.-)"..delimiter) do
        if string.match(match, ":!cd build*.")==nil then
            if string.len(match)>0 then
                table.insert(lines, match)
            end
        end
    end

    -- local errorformat = {
    --     -- " %#%f:%l %#(%m)",
    --     "%-G\\s%#",
    --     "CMake Error at %f:%l %m:",
    --     "%I Target links to ",
    --     "%C %s%#%m",
    --     "%C %m, %ZCall",
    --     "%ZCall Stack %m",
    --     "%N %f:%l (%m)"
    -- }
    -- local errorformat = {
    --     -- " %#%f:%l %#(%m)",
    --     "%-G\\s%#",
    --     "%ECMake Error at %f:%l (%m):",
    --     "%C %m, %ZCall",
    --     "%ZCall Stack %m",
    --     "%N %f:%l (%m)"
    -- }
    local errorformat = {
        -- " %#%f:%l %#(%m)",
        -- "%-G\\s%#",
        "%IDone",
        "%ECMake Error at %f:%l\\ %m:",
        "%C  Target %o",
        "%Z  %m",
        -- "%ICall Stack (%m):",
        -- "%C %f:%l (%o)",
        -- "%ICall Stack %m:$",
        "%I  %f:%l %m",
        -- "%C\\\\ Target %m",
        -- "%*\\w%.%#",
        -- "%C    Target %m",
        -- "%-G  but the target was",
        -- "%C %.%#",
        -- "%Z%.%#",
        -- "%ZCall",
        -- "%-G\\s%#",
        "%-G\\s%#",
    }
    -- local errorformat = {
    --     -- "%C%.%#",
    --     -- %.%#
    --     " %#%f:%l %#(%m)",
    --     "%ECMake Error at %f:%l (%m):",
    --     -- "Call%.%#",
    --     "\\ %.%f:%l ",
    --     -- "%C #%f:%l %#(%m)",
    --     "%ZCall Stack %.%#",
    --     -- "% %m"
    -- }
    vim.fn.setqflist({},'r', {lines=lines, title=cmd, efm=table.concat(errorformat, ",")})
    -- vim.fn.setqflist({},'r', {lines=lines, title=cmd})

end
