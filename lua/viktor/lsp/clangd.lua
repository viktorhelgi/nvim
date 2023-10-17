local function on_attach(client, bufnr)
	local opt = { noremap = true, silent = false, buffer = bufnr }

	-- "Goto FileType Config"
	vim.keymap.set("n", "'L", "<CMD>e ~/.config/nvim/lua/viktor/lsp/clangd.lua<CR>", opt)

	vim.cmd("set colorcolumn=102")

	require("lsp_signature").on_attach(require("viktor.config.plugin.lsp_signature"), bufnr) -- no need to specify bufnr if you don't use toggle_key

	-- require("lint").linters_by_ft = { cpp = { "cpplint", "clang-tidy" } }

	vim.keymap.set("n", "<leader>ef", function()
		vim.cmd(":setlocal foldmarker=#ifdef,#endif")
		vim.cmd(":set foldmethod=marker")
	end, opt)

	vim.keymap.set({ "n" }, "gs", function()
		-- require("lsp_signature").toggle_float_win()
		vim.lsp.buf.signature_help()
	end, { buffer = bufnr, silent = true, noremap = true, desc = "toggle signature" })
	-- vim.keymap.set({ 'n' }, 'gs', vim.lsp.buf.signature_help, { silent = true, noremap = true, desc = 'toggle signature' })

	vim.keymap.set("n", "<leader>rb", function()
		vim.cmd("Task start cmake build")
	end, opt)

	vim.keymap.set("n", "<leader>rc", function()
		vim.cmd("Task start cmake configure")
	end, opt)

	vim.keymap.set("n", "<leader>cg", require("neogen").generate, opt)

	vim.keymap.set("n", "<leader>rn", function()
		require("cpp_test").run_test(vim.fn.expand("%:p"))
	end, opt)

	vim.keymap.set("n", "gk", function()
		vim.cmd("TSTextobjectPeekDefinitionCode @function.inner")
	end, { desc = "peek definition" })

	vim.keymap.set("n", "<leader>cd", vim.diagnostic.setqflist, opt)

	opt["desc"] = "run function"
	vim.keymap.set("n", "<leader>rp", function()
		local file_relpath = vim.fn.expand("%:r")
		local executable = "./build/" .. file_relpath

		require("harpoon.tmux").sendCommand("!", 'echo; echo "RUN MAKE"; echo; ' .. "make -C build; " .. "\r")
		require("harpoon.tmux").sendCommand("!", 'echo; echo "Run Executable"; echo; ' .. executable .. "; " .. "\r")
	end, opt)

	require("which-key").register({
		c = {
			r = {
				function()
					vim.cmd("Task start cmake run")
				end,
				"make",
			},
			l = {
				function()
					local cmd = "cd build && ctest && cd .."
					require("harpoon.tmux").sendCommand("1", "^c")
					require("harpoon.tmux").sendCommand("!", cmd .. "\r")
				end,
				"test",
			},
			b = {
				function()
					local items = {
						"normal",
						"vcpkg",
					}
					vim.ui.select(items, {
						prompt = "Select Build",
					}, function(tg)
						local cmd
						if tg == "normal" then
							cmd =
								"cmake -B build -S . -DCMAKE_TOOLCHAIN_FILE=/home/viktorhg/git-repos/vcpkg/scripts/buildsystems/vcpkg.cmake"
						elseif tg == "vcpkg" then
							cmd = "cmake -B build -S . -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=DEBUG"
						end
						require("harpoon.tmux").sendCommand("1", "^c")
						require("harpoon.tmux").sendCommand("!", cmd .. "\r")
					end)
				end,
				"build",
			},
		},
	})

	-- require('inlay-hints').on_attach(client, bufnr)
end

require("lspconfig").clangd.setup({
	on_attach = on_attach,
	filetypes = { "c", "hpp", "cpp", "objc", "objcpp", "cuda", "proto" },
	settings = {
		clangd = {
			arguments = {
				"--background-index",
				"-j=12",
				-- "--query-driver=/usr/bin/**/clang-*,/bin/clang,/bin/clang++,/usr/bin/gcc,/usr/bin/g++",
				"--clang-tidy",
				"--clang-tidy-checks=*",
				"--all-scopes-completion",
				"--cross-file-rename",
				"--completion-style=detailed",
				"--header-insertion-decorators",
				"--header-insertion=iwyu",
				"--pch-storage=memory",
			},
			checkUpdates = false,
			detectExtensionConflicts = true,
			fallbackFlags = {},
			inactiveRegions = {
				opacity = 0.55,
				useBackgroundHighlight = false,
			},
			onConfigChanged = "prompt",
			path = "clangd",
			restartAfterCrash = true,
			semanticHighlighting = true,
			serverCompletionRanking = true,
			-- trace = "some-string",
		},
	},
})
