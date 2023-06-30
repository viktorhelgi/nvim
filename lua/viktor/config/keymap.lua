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
        ["l"] = { require("harpoon.ui").nav_next, "goto next mark" },
        h = { require('harpoon.ui').nav_next, "harpoon"},
        t = { _cmd("TSTextobjectRepeatLastMoveNext"), "ts: repeat"},
	},
	["["] = {
		name = "Goto Prev",
		d = { vim.diagnostic.goto_prev, "diagnostic" },
        ["l"] = { require("harpoon.ui").nav_prev, "goto prev mark" 	},
        h = { require('harpoon.ui').nav_prev, "harpoon"},
        t = { _cmd("TSTextobjectRepeatLastMovePrevious"), "ts: repeat"},
    },
	y = {
		name = "yank",
		s = { 'viw"ly' },
	},
	g = {
		name = "+goto",
        c = { _cmd("e Cargo.toml"), "Cargo.toml"},
		d = {
			function()
				vim.lsp.buf.definition({
					on_list = function(options)
						vim.fn.setqflist({}, " ", options)
						vim.api.nvim_command("cfirst")
					end,
				})
			end,
			"definition",
		},
		h = { vim.lsp.buf.hover, "hover" },
		k = { vim.lsp.buf.hover, "hover" },
		s = { vim.lsp.buf.signature_help, "signature_help" },
		-- t = { require('telescope.builtin').lsp_type_deftnitions, "type-definition" }
		t = { vim.lsp.buf.type_definition, "type-definition" },
		r = { vim.lsp.buf.references, "references" },
	},
	["<leader>"] = {
		[","] = { _cmd("Telescope file_browser path=%:p:h theme=dropdown"), "File Browser" },
		["~"] = { _cmd("messages"), "messages" },
		["-"] = { _cmd("b#"), "b#" },
		q = { _cmd("q"), "quit" },
        Q = { _cmd("confirm qa"), "quit-all"},
		s = { _cmd("w"), "save" },
		z = { _cmd("ZenMode"), "Zen mode" },
		[";"] = {
			name = "letsgo",
			t = {
				function()
					vim.cmd("NvimTreeToggle")
				end,
				"something",
			},
			f = {
				function()
					vim.cmd("NvimTreeFindFile")
				end,
				"something",
			},
			r = {
				function()
					vim.cmd("NvimTreeRefresh")
				end,
				"something",
			},
		},
		b = {
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

			d = { vim.diagnostic.setqflist, "diags to qflist" },
			q = {
				function()
					vim.cmd("ccl")
				end,
				"ccl",
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
					-- vim.cmd('Trouble quickfix')
					require("keys").register_jump_mappings("qf")
					-- require('keys').register_jump_mappings("Trouble")
				end,
				"open",
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
		e = {
			["|"] = {
				function()
					require("viktor.vim.libs").conf(vim.fn.expand("%"))
				end,
				"dont know",
			},
			a = { _cmd("AerialToggle"), "Aerial Toggle" },
            b = {
                s = { function()
                        vim.cmd("set scrollbind")
                        vim.cmd("set cursorbind")
                    end, "window bind"
                },
                x = { function()
                        vim.cmd("set noscrollbind")
                        vim.cmd("set nocursorbind")
                    end, "window bind off"
                }
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
            o = { _cmd("Git"), ":Git"},
            c = { _cmd("Git commit"), "commit"},
            q = { function()
                require("keys").register_jump_mappings("qf")
                vim.cmd("Git difftool")
            end, "qflist"},
			d = {
				name = "git-diff",
				h = { _cmd("DiffviewOpen"), "HEAD" },
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
            p = { _cmd("Gitsigns preview_hunk_inline"), "preview hunk"},
		},
		h = {
			name = "harpoon/git",
			["'"] = { require("harpoon.mark").add_file, "mark file" },
			t = { require("harpoon.ui").toggle_quick_menu, "toggle menu" },
			-- n = { require("harpoon.ui").nav_next, "goto next mark" },
			-- p = { require("harpoon.ui").nav_prev, "goto prev mark" },

            p = { require('gitsigns.actions').preview_hunk_inline,  "preview_hunk"},
            s = { require('gitsigns.actions').stage_hunk,  "stage hunk"},
            u = { require('gitsigns.actions').undo_stage_hunk,  "undo stage hunk"},
            b = { require('gitsigns.actions').blame_line,  "undo stage hunk"},
		},
		-- o = {
		--     name = "Trouble",
		--     l = { function() vim.cmd('Trouble loclist') end, "loclist" },
		--     q = { function() vim.cmd('Trouble quickfix') end, "quickfix" },
		--     r = { function() vim.cmd('Trouble lsp_references') end, "lsp_references" },
		--     f = { function() vim.cmd('Trouble lsp_definitions') end, "lsp_definitions" },
		--     i = { function() vim.cmd('Trouble lsp_implementations') end, "lsp_implementations" },
		--     t = { function() vim.cmd('Trouble lsp_type_definitions') end, "lsp_type_definitions" },
		--     d = { function() vim.cmd('Trouble document_diagnostics') end, "document_diagnostics" },
		--     w = { function() vim.cmd('Trouble workspace_diagnostics') end, "workspace_diagnostics" },
		-- },

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
				r = { _cmd("Neorg workspace rust-main"), "rust-main" },
				n = { _cmd("Neorg workspace research"), "research" },
				d = { _cmd("Neorg workspace default"), "default" },
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
			e = {
				function()
					require("telescope.builtin").find_files({ cwd = require("telescope.utils").buffer_dir() })
				end,
				"files in %:p:h",
			},
			o = { require("telescope.builtin").buffers, "buffers" },
			-- k = { require("telescope.builtin").live_grep, "live grep" },
			k = { require('telescope').extensions.live_grep_args.live_grep_args, "live grep" },
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
            m = { _cmd("WindowsMaximize"), "maximize"},
            e = { _cmd("WindowsEqualize"), "equalize"}
        }
	},
})

require("viktor.lib.funcs").cmd_mappings("i", {
	-- ['<C-space>'] = '<C-x><C-o>',
	-- ['<C-o>'] = '<C-x><C-o>',
	["<C-f>"] = "<C-x><C-f>",
})

require("viktor.lib.funcs").cmd_mappings("v", {
	["<leader>"] = {
		e = {
			y = '"+y',
		},
	},
})

require("viktor.lib.funcs").cmd_mappings("t", {
	["<esc>"] = "<C-\\><C-n>",
	["<C-q>"] = "<C-\\><C-n>",
	["<C-j>"] = "<Down>",
	["<C-k>"] = "<Up>",
})

require("viktor.lib.funcs").cmd_mappings("c", {
	["<C-j>"] = "<Down>",
	["<C-k>"] = "<Up>",
})
