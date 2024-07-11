vim.cmd([[
    autocmd FileType cpp lua RegisterFTKeymaps.Cpp()
]])

local CMAKE_BUILD_TYPE = 'TESTING'

RegisterFTKeymaps.Cpp = function()
	vim.cmd('set colorcolumn=102')

	require('which-key').register({
		g = {
			name = 'Goto',
			k = {
				function()
					vim.cmd('TSTextobjectPeekDefinitionCode @function.inner')
				end,
				'peek definition',
			},
		},
		c = {
			['*'] = {
				function()
					vim.cmd('Task start cmake build -- -j 12')
					-- cmake --build build -- -j $(nproc)
				end,
				'cmake build',
			},
			['b'] = {
				function()
					local items = {
						'normal',
						'vcpkg',
					}
					vim.ui.select(items, {
						prompt = 'Select Build',
					}, function(tg)
						local cmd
						if tg == 'normal' then
							cmd = 'cmake -B build -S . -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE='
								.. CMAKE_BUILD_TYPE
								.. ' -DENABLE_TIME_CONSUMING_TESTS=OFF'
						elseif tg == 'vcpkg' then
							cmd =
								'cmake -B build -S . -DCMAKE_TOOLCHAIN_FILE=/home/viktorhg/git-repos/vcpkg/scripts/buildsystems/vcpkg.cmake'
						end
						require('harpoon.tmux').sendCommand('1', '^c')
						require('harpoon.tmux').sendCommand('!', cmd .. '\r')
					end)
				end,
				'build',
			},
		},
		['<leader>'] = {
			c = {
				name = '...',
				g = { require('neogen').generate, 'Generate Docs' },
				r = {
					function()
						vim.cmd('Task start cmake run')
					end,
					'make',
				},
				l = {
					function()
						local cmd = 'cd build && ctest && cd ..'
						require('harpoon.tmux').sendCommand('1', '^c')
						require('harpoon.tmux').sendCommand('!', cmd .. '\r')
					end,
					'test',
				},
				b = {
					function()
						local items = {
							'normal',
							'vcpkg',
						}
						vim.ui.select(items, {
							prompt = 'Select Build',
						}, function(tg)
							local cmd
							if tg == 'normal' then
								cmd = 'cmake -B build -S . -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE='
									.. CMAKE_BUILD_TYPE
									.. ' -DENABLE_TIME_CONSUMING_TESTS=OFF'
							elseif tg == 'vcpkg' then
								cmd =
									'cmake -B build -S . -DCMAKE_TOOLCHAIN_FILE=/home/viktorhg/git-repos/vcpkg/scripts/buildsystems/vcpkg.cmake'
							end
							require('harpoon.tmux').sendCommand('1', '^c')
							require('harpoon.tmux').sendCommand('!', cmd .. '\r')
						end)
					end,
					'build',
				},
			},
			f = {
				name = 'fold',
				i = {
					function()
						-- vim.cmd(':setlocal foldmarker=#ifdef,#endif')
						vim.cmd(':setlocal foldmarker=#if,#endif')
						vim.cmd(':set foldmethod=marker')
					end,
					"fold 'ifdef'..",
				},
			},
            m = {
                name = "man",
                o = {
                    function() require('cppman').open_cppman_for(vim.fn.expand('<cword>')) end,
                    "open cppman for word under cursor"
                },
                i = {
                    function() require('cppman').input() end,
                    "open cppman for input"
                }
            },
			p = {
				function()
					local file_relpath = vim.fn.expand('%:r')
					local executable = './build/' .. file_relpath

					local cmd1 = 'echo; echo "RUN MAKE"; echo; ' .. 'make -C build; ' .. '\r'
					local cmd2 = 'echo; echo "Run Executable"; echo; ' .. executable .. '; ' .. '\r'
					require('harpoon.tmux').sendCommand('!', cmd1)
					require('harpoon.tmux').sendCommand('!', cmd2)
				end,
				'Run Function',
			},
			r = {
				name = 'Run',
                -- stylua: ignore start
                b = {
                    function() vim.cmd("Task start cmake build") end,
                    "cmake build"
                },
                c = {
                    function() vim.cmd("Task start cmake configure") end,
                    "cmake configure"
                },
                f = {
                    function() 
		                require("cpp_test").run_file(vim.fn.expand("%:p"))
                    end,
                    "file: g++ -o file file.cpp && ./file"
                },


                n = {
                    function()
		                require("cpp_test").run_test2(vim.fn.expand("%:p"))
                    end,
                    "test file"
                },

                l = { require('cpp_test').run_last, "last command" }
,
				-- stylua: ignore end
			},
		},
	}, { -- Options
		mode = 'n',
		noremap = true,
		silent = true,
		buffer = vim.api.nvim_get_current_buf(),
	})
end
