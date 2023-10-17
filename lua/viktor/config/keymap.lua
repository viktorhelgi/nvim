local function _cmd(command)
	if type(command) == "string" then
		return "<CMD>" .. command .. "<CR>"
	elseif type(command) == "table" then
		local out = ""
		for _, v in ipairs(command) do
			out = out .. "<CMD>" .. v .. "<CR>"
		end
		return out
	end
end

-- NORMAL - NOT with LEADER
require("which-key").register({
	["<C-h>"] = {
		function()
			vim.cmd("wincmd h")
		end,
		"left window",
	},
	["<C-l>"] = {
		function()
			vim.cmd("wincmd l")
		end,
		"left window",
	},
	["<C-k>"] = {
		function()
			vim.cmd("wincmd k")
		end,
		"left window",
	},
	["<C-j>"] = {
		function()
			vim.cmd("wincmd j")
		end,
		"left window",
	},

	["'"] = {
		name = "Navigate to",
		h = {
			function()
				require("harpoon.ui").nav_file(1)
			end,
			"1st",
		},
		t = {
			function()
				require("harpoon.ui").nav_file(2)
			end,
			"2nd",
		},
		n = {
			function()
				require("harpoon.ui").nav_file(3)
			end,
			"3rd",
		},
		s = {
			function()
				require("harpoon.ui").nav_file(4)
			end,
			"4th",
		},
		["-"] = {
			function()
				require("harpoon.ui").nav_file(5)
			end,
			"5th",
		},
		m = {
			function()
				require("harpoon.term").gotoTerminal(1)
			end,
			"1st-term",
		},
		w = {
			function()
				require("harpoon.term").gotoTerminal(2)
			end,
			"2nd-term",
		},
		c = {
			function()
				vim.cmd("ClangdSwitchSourceHeader")
			end,
			"clang-switch",
		},
		q = {
			function()
				vim.cmd("Fcarbon %:p:h")
			end,
			"fcarbon",
		},
		b = { _cmd("b#"), "b#" },
		["/"] = { _cmd("A"), "src-test" },
	},

	["]"] = {
		name = "Goto Next",
		d = { vim.diagnostic.goto_next, "diagnostic" },
		g = { _cmd("Gitsigns next_hunk"), "next hunk" },
		h = { require("harpoon.ui").nav_next, "harpoon" },
		-- ["l"] = { require("harpoon.ui").nav_next, "goto next mark" },
        l = { function()
            require('neotest').jump.next({status = "failed"})
        end, "failed test"},
		t = { _cmd("TSTextobjectRepeatLastMoveNext"), "ts: repeat" },
	},

	["["] = {
		name = "Goto Prev",
		d = { vim.diagnostic.goto_prev, "diagnostic" },
		g = { _cmd("Gitsigns prev_hunk"), "prev hunk" },
		h = { require("harpoon.ui").nav_prev, "harpoon" },
		-- ["l"] = { require("harpoon.ui").nav_prev, "goto prev mark" },
        l = { function()
            require('neotest').jump.prev({status = "failed"})
        end, "failed test"},
		t = { _cmd("TSTextobjectRepeatLastMovePrevious"), "ts: repeat" },
	},

    c = {
        name = "lists",
		d = { vim.diagnostic.setqflist, "setqflist" },
		q = { _cmd("cclose"), "close" },
    },

	d = {
        name = "diagnostics",
		o = { vim.diagnostic.open_float, "open-float" },
	},

	g = {
		name = "+goto",
		c = { _cmd("e Cargo.toml"), "Cargo.toml" },
		d = {
			function()
				vim.lsp.buf.definition({
					-- on_list = function(options)
					--                    if 1 < #options.items then
					--                        vim.print(options)
					--                        vim.fn.setqflist({}, " ", options)
					--                    end
					--                    vim.api.nvim_command("cfirst")
					-- end,
				})
			end,
			"definition",
		},
		D = { vim.lsp.buf.declaration, "declaration" },
		h = { vim.lsp.buf.hover, "hover" },
		i = { vim.lsp.buf.implementation, "impl" },
		k = { _cmd("TSTextobjectPeekDefinitionCode @function.inner"), "peek definition" },
		s = { vim.lsp.buf.signature_help, "signature_help" },
		-- t = { require('telescope.builtin').lsp_type_deftnitions, "type-definition" }
		t = { vim.lsp.buf.type_definition, "type-definition" },
		r = { vim.lsp.buf.references, "references" },
	},

	y = {
		name = "yank",
		s = { 'viw"ly' },
	},
})

-- NORMAL - LEADER
require("which-key").register({
	["<leader>"] = {
		[","] = { _cmd("Telescope file_browser path=%:p:h theme=dropdown"), "File Browser" },
		["|"] = { _cmd("messages"), "messages" },
		["~"] = { function() vim.print("REMEMBER: use <leader>| now") end, "messages" },
		["-"] = { _cmd("b#"), "b#" },
		q = { _cmd("q"), "quit" },
		Q = { _cmd("confirm qa"), "quit-all" },
		G = { _cmd("Git"), "Git" },
		s = { _cmd("w"), "save" },
		z = { _cmd("ZenMode"), "Zen mode" },

		b = {
            name = "buffer",
			n = { "<cmd>bn<cr>" },
			p = { "<cmd>bp<cr>" },
		},

		c = {
			name = "lists",
			P = { vim.cmd.colder, "older" },
			N = { vim.cmd.cnewer, "Newer" },
			c = {
				function() -- '<cmd>ccl<cr><cmd>TroubleClose<cr>'
					vim.cmd("ccl")
					vim.cmd("TroubleClose")
				end,
				"close",
			},
            g = { "<CMD>Gitsigns setqflist<CR>", "Git changes" },
			d = { vim.diagnostic.setqflist, "diags to qflist" },
			q = {
				function()
					vim.cmd("cclose")
					vim.cmd("lclose")
				end,
				"close",
			},
			i = {
				function()
					for _, opts in ipairs(vim.fn.getwininfo()) do
						local ft = vim.api.nvim_buf_get_option(opts["bufnr"], "filetype")
						local status, result = pcall(require("keys").register_jump_mappings, ft)
						if status then
							print("keymap registered for " .. ft)
							return
						else
							print("error: " .. result)
						end
					end
				end,
				"set-keymaps",
			},
			o = {
				function()
					vim.cmd("copen")
					require("keys").register_jump_mappings("qf")
				end,
				"open qf-list",
			},
			l = {
				function()
					vim.cmd("lopen")
					require("keys").register_jump_mappings("loclist")
				end,
				"open loc-list",
			},
			n = { "<cmd>cn<cr>", "next" },
			p = { "<cmd>cp<cr>", "prev" },
			s = {
				function() -- ':vimgrep /\\.<C-r>l/g %<CR>:Trouble quickfix<CR>',
					vim.cmd(":vimgrep /\\.<C-r>l/g %")
					vim.cmd("copen")
					-- vim.cmd('Trouble quickfix')
				end,
				"/\\.<C-r>l/g %",
			},
		},

		d = {
			name = "diagnostic",
			t = { require("diagnostic_funcs").toggle, "toggle" },
			s = { vim.diagnostic.open_float, "open-float" },
			l = {
				name = "location list",
				a = {
					function()
						require("diagnostic_funcs").loclist()
					end,
					"All",
				},
				e = {
					function()
						require("diagnostic_funcs").loclist(vim.diagnostic.severity.ERROR)
					end,
					"ERROR",
				},
				h = {
					function()
						require("diagnostic_funcs").loclist(vim.diagnostic.severity.HINT)
					end,
					"HINT",
				},
				w = {
					function()
						require("diagnostic_funcs").loclist(vim.diagnostic.severity.WARN)
					end,
					"WARN",
				},
				i = {
					function()
						require("diagnostic_funcs").loclist(vim.diagnostic.severity.INFO)
					end,
					"INFO",
				},
			},
			c = {
				name = "qflist",
				a = {
					function()
						require("diagnostic_funcs").qflist()
					end,
					"All",
				},
				e = {
					function()
						require("diagnostic_funcs").qflist(vim.diagnostic.severity.ERROR)
					end,
					"ERROR",
				},
				h = {
					function()
						require("diagnostic_funcs").qflist(vim.diagnostic.severity.HINT)
					end,
					"HINT",
				},
				w = {
					function()
						require("diagnostic_funcs").qflist(vim.diagnostic.severity.WARN)
					end,
					"WARN",
				},
				i = {
					function()
						require("diagnostic_funcs").qflist(vim.diagnostic.severity.INFO)
					end,
					"INFO",
				},
			},
		},

		e = {
            name = "extras",
			["|"] = {
				function()
					require("viktor.vim.libs").conf(vim.fn.expand("%"))
				end,
				"dont know",
			},
			a = { _cmd("AerialToggle"), "Aerial Toggle" },
			b = {
				s = {
					function()
						vim.cmd("set scrollbind")
						vim.cmd("set cursorbind")
					end,
					"window bind",
				},
				x = {
					function()
						vim.cmd("set noscrollbind")
						vim.cmd("set nocursorbind")
					end,
					"window bind off",
				},
			},
			c = { _cmd("cd %:p:h"), "cd %:p:h" },
			f = {
				name = "fold",
				i = {
					function()
						vim.cmd("set foldmethod=indent")
					end,
					"indent",
				},
				s = {
					function()
						vim.cmd("set foldmethod=syntax")
					end,
					"syntax",
				},
				m = {
					function()
						vim.cmd("set foldmethod=manual")
					end,
					"manual",
				},
			},
			h = {
				function()
					vim.cmd("set hlsearch!")
				end,
				"set hlsearch!",
			},
            l = {
                function()
                    vim.cmd("LineNumberIntervalToggle")
                end,
                "LineNumberIntervalEnable"
            },
			p = { '"+p', "paste" },
			s = { _cmd("so %"), "source %" },
			t = {
				name = "terminal",
				v = { _cmd("vs | terminal") .. "i", "split vertical" },
				s = { _cmd("sp | terminal") .. "i", "split horizontal" },
			},
			["-"] = { _cmd("cd .."), "cd .." },
		},

		g = {
			name = "Git",
			o = { _cmd("Git"), ":Git" },
			c = { _cmd("Git commit"), "commit" },
			q = {
                name = "setqflist",
                a = {
                    function()
                        require("keys").register_jump_mappings("qf")
                        vim.cmd("Git difftool")
                    end,
                    "all hunks",
                },
                f = {
                    function()
                        require("keys").register_jump_mappings("qf")
                        vim.cmd("Gitsigns setqflist")
                    end,
                    "current file"
                }
			},
			D = {
				function()
					vim.ui.input({ prompt = "git diff " }, function(input)
						vim.cmd("DiffviewOpen " .. input)
					end)
				end,
				"Git-Diff",
			},
			d = {
				name = "git-diff",
				b = {
					function()
						vim.ui.input({ prompt = "Number of HEADS Back: " }, function(count)
							vim.cmd("DiffviewOpen HEAD" .. string.rep("^", count))
						end)
					end,
					"SELECT",
				},
				h = {
					function()
						vim.cmd("DiffviewOpen")
					end,
					"HEAD",
				},
				s = {
					function()
						vim.ui.select({ "HEAD^", "HEAD^^..HEAD^" }, { prompt = "Select" }, function(choice)
							vim.cmd("DiffviewOpen " .. choice)
						end)
					end,
					"SELECT",
				},
				f = { _cmd("DiffviewFileHistory"), "file history" },
				q = { _cmd("DiffviewClose"), "quit" },
			},
			P = { _cmd("Gitsigns preview_hunk_inline"), "preview hunk" },
		},

		h = {
			name = "harpoon/git",
			["'"] = { require("harpoon.mark").add_file, "mark file" },
			t = { require("harpoon.ui").toggle_quick_menu, "toggle menu" },
			-- n = { require("harpoon.ui").nav_next, "goto next mark" },
			-- p = { require("harpoon.ui").nav_prev, "goto prev mark" },
			u = { require("gitsigns.actions").undo_stage_hunk, "undo stage hunk" },
			p = { require("gitsigns.actions").preview_hunk_inline, "preview_hunk" },
			b = { require("gitsigns.actions").blame_line, "blame line" },
			s = { ":Gitsigns stage_hunk<CR>", "stage hunk" },
			r = {
				function()
					require("harpoon.tmux").sendCommand("!", "^p")
					require("harpoon.tmux").sendCommand("!", "\r")
				end,
				"tmux: prev-cmd",
			},
		},

		l = {
			name = "LSP",
			-- a = { vim.lsp.buf.code_action, "code action" },
			a = { require("code_action_menu").open_code_action_menu, "code action" },
			d = {
				name = "Document",
				-- ['c'] = '[cmd] lua vim.lsp.buf.declaration()',
				-- ['f'] = '[cmd] lua vim.lsp.buf.definition()',
				h = { vim.lsp.buf.document_highlight, "highlight" },
				s = { vim.lsp.buf.document_symbol, "symbol" },
			},
			-- ['f'] = { ['1'] = '[cmd] lua vim.lsp.buf.format()', ['2'] = '[cmd] lua vim.lsp.buf.formatting()', ['3'] = '[cmd] lua vim.lsp.buf.formatting_seq_sync()', ['4'] = '[cmd] lua vim.lsp.buf.formatting_sync()', },
			e = { vim.lsp.buf.execute_command, "execute command" },
			-- f = { vim.lsp.buf.format, "format" },
			f = {
				function()
					vim.cmd("Format")
				end,
				"format",
			},
			h = { vim.lsp.buf.hover, "hover" },
			i = { vim.lsp.buf.implementation, "implementation" },
			I = { vim.lsp.buf.incoming_calls, "incoming calls" },
			o = { vim.lsp.buf.outgoing_calls, "outgoing calls" },
			r = { vim.lsp.buf.rename, "rename" },
			-- r = {
			--     c = { vim.lsp.buf.range_code_action, "range code action" },
			--     f = { vim.lsp.buf.range_formatting, "range formatting" },
			--     e = { vim.lsp.buf.references, "references" },
			--     n = { vim.lsp.buf.rename, "rename" },
			-- },
			R = { vim.lsp.buf.rename, "rename" },
			s = {
				r = { vim.lsp.buf.server_ready, "server ready" },
				h = { vim.lsp.buf.signature_help, "signature help" },
			},
			t = { vim.lsp.buf.type_definition, "type definition" },
			w = {
				name = "workspace",
				a = { vim.lsp.buf.add_workspace_folder, "add workspace folder" },
				r = { vim.lsp.buf.remove_workspace_folder, "remove_workspace_folder" },
				l = { vim.lsp.buf.list_workspace_folders, "list_workspace_folders" },
			},
		},

		L = {
			i = { _cmd("LspInfo"), "LSPInfo" },
			m = { _cmd("Mason"), "Mason" },
		},

		n = {
			name = "Neorg",
			c = {
				function()
					if _G._neorg_concealed then
						vim.cmd("setlocal concealcursor=")
						_G._neorg_concealed = false
					else
						vim.cmd("setlocal concealcursor=inv")
						_G._neorg_concealed = true
					end
				end,
				"toggle-concealer",
			},
			C = { _cmd("Neorg toggle-concealer"), "toggle-concealer" },
			o = {
				name = "Open",
				r = { _cmd("Neorg workspace rust"), "rust" },
				n = { _cmd("Neorg workspace research"), "research" },
				d = { _cmd("Neorg workspace general"), "default" },
			},
			j = {
				t = { _cmd("Neorg journal today"), "today" },
				c = { _cmd("Neorg journal custom"), "custom" },
				T = { _cmd("Neorg journal template"), "template" },
				n = { _cmd("Neorg journal tomorrow"), "tomorrow" },
				y = { _cmd("Neorg journal yesterday"), "yesterday" },
			},
			t = {
				name = "TOC",
				l = { _cmd("Neorg toc left"), "left" },
				r = { _cmd("Neorg toc right"), "right" },
				q = { _cmd("Neorg toc qflist"), "qflist" },
			},
			T = { _cmd("Neorg tangle"), "Tangle" },
			m = {
				name = "mode",
				n = { _cmd("Neorg mode norg"), "norg" },
				t = { _cmd("Neorg mode traverse-heading"), "traverse-heading" },
				l = { _cmd("Neorg module list"), "list" },
				L = { _cmd("Neorg module load"), "load" },
			},
			i = { _cmd("Neorg index"), "index" },
			I = { _cmd("Neorg inject-metadata"), "inject-metadata" },
			U = { _cmd("Neorg update-metadata"), "update-metadata" },
			r = { _cmd("Neorg return"), "return" },
			-- t = { _cmd("Neorg tangle"), ""},
			-- k = { _cmd("Neorg keybind"), ""},
			-- u = { _cmd("Neorg upgrade"), ""},
			-- w = { _cmd("Neorg workspace"), ""},
			-- s = { _cmd("Neorg sync-parsers"), ""},
			-- i = { _cmd("Neorg inject-metadata"), ""},
			-- u = { _cmd("Neorg update-metadata"), ""},
			-- t = { _cmd("Neorg toggle-concealer"), ""},
		},

		m = {
			name = "Mini",
			o = {
				require("mini.files").open,
				"Files Open",
			},
			[","] = {
				function()
					require("mini.files").open(vim.fn.expand("%"))
				end,
				"Files Open (file)",
			},
			t = {
				require("mini.map").toggle,
				"Map toggle",
			},
			l = {
				require("mini.map").toggle_focus,
				"Map focus",
			},
		},

		P = {
			name = "Packer",
			r = { _cmd("PackerClean"), "PackerClean" },
			c = { _cmd("PackerCompile"), "PackerCompile" },
			i = { _cmd("PackerInstall"), "PackerInstall" },
			l = { _cmd("PackerLoad"), "PackerLoad" },
			p = { _cmd("PackerProfile"), "PackerProfile" },
			s = { _cmd("PackerStatus"), "PackerStatus" },
			u = { _cmd("PackerUpdate"), "PackerUpdate" },
			S = {
				name = "Snapshot",
				c = { _cmd("PackerSnapshot"), "PackerSnapshot" },
				d = { _cmd("PackerSnapshotDelete"), "PackerSnapshotDelete" },
				r = { _cmd("PackerSnapshotRollback"), "PackerSnapshotRollback" },
			},
			["-"] = { _cmd("PackerSync"), "PackerSync" },
		},

		T = { _cmd("Telescope"), "Telescope" },

		t = {
			name = "Telescope",
			a = { _cmd("Telescope aerial"), "aerial" },
			c = { _cmd("Telescope colorscheme path=%:p:h theme=dropdown"), "colorscheme" },
			e = {
				function() require("telescope.builtin").find_files({ cwd = require("telescope.utils").buffer_dir() }) end,
				"files in %:p:h",
			},
			o = { require("telescope.builtin").buffers, "buffers" },
			-- k = { require("telescope.builtin").live_grep, "live grep" },
			k = { require("telescope").extensions.live_grep_args.live_grep_args, "live grep" },
			j = {
				function()
					require("telescope.builtin").live_grep({ cwd = require("telescope.utils").buffer_dir() })
				end,
				"live grep in %:p:h",
			},
			g = {
				name = "git",
				s = {
					function()
						vim.cmd("Telescope git_status")
					end,
					"status",
				},
				b = {
					function()
						vim.cmd("Telescope git_branches")
					end,
					"branches",
				},
				c = {
					function()
						vim.cmd("Telescope git_commits")
					end,
					"commits",
				},
			},
			["'"] = { require("telescope.builtin").marks, "marks" },
			[","] = { _cmd("Telescope file_browser path=%:p:h"), "File Browser" },
			b = { _cmd("Telescope file_browser theme=dropdown"), "File Browser (cwd)" },
			m = { require("telescope.builtin").keymaps, "keymaps" },
			-- n = { function() require("trouble").next({ skip_groups = true, jump = true }) end, "Trouble next" },
			-- p = { function() require("trouble").previous({ skip_groups = true, jump = true }) end, "Trouble prev" },
			-- c = { _cmd('TroubleClose'), "TroubleClose" },
			-- C = { require('telescope.builtin').colorscheme({theme='dropdown'}), "Colorscheme"},
			C = { _cmd("Telescope colorscheme theme=dropdown"), "Colorscheme" },
			-- r = { _cmd('TroubleRefresh'), "TroubleRefresh" },
			r = { require("telescope.builtin").resume, "resume" },
			u = { require("telescope.builtin").find_files, "files" },
			w = { require("telescope.builtin").lsp_workspace_symbols, "ws symbols" },
		},

		w = {
			name = "Window",
			m = { _cmd("WindowsMaximize"), "maximize" },
			e = { _cmd("WindowsEqualize"), "equalize" },
		},
	},
})

-- VISUAL MODE
require("which-key").register({
	["<leader>"] = {
		h = {
			s = { ":Gitsigns stage_hunk<CR>", "stage hunk" },
		},
	},
}, {
	mode = "v",
})

require("viktor.lib.funcs").cmd_mappings("v", {
	["<leader>"] = {
		e = {
			y = '"+y',
		},
	},
})


-- INSERT MODE
require("viktor.lib.funcs").cmd_mappings("i", {
	-- ['<C-space>'] = '<C-x><C-o>',
	-- ['<C-o>'] = '<C-x><C-o>',
	["<C-f>"] = "<C-x><C-f>",
})

-- TERMINAL MODE
require("viktor.lib.funcs").cmd_mappings("t", {
	["<esc>"] = "<C-\\><C-n>",
	["<C-q>"] = "<C-\\><C-n>",
	["<C-j>"] = "<Down>",
	["<C-k>"] = "<Up>",
})

-- COMMAND MODE
require("viktor.lib.funcs").cmd_mappings("c", {
	["<C-j>"] = "<Down>",
	["<C-k>"] = "<Up>",
})
