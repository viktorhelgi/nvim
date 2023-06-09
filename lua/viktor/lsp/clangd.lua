require("lspconfig").clangd.setup({
	on_attach = function(_, bufnr)

		local opt = { noremap = true, silent = false, buffer = bufnr }

        -- "Goto FileType Config"
        vim.keymap.set("n", "'L", "<CMD>e ~/.config/nvim/lua/viktor/lsp/clangd.lua<CR>", opt)

		vim.cmd("set colorcolumn=102")

		require("lsp_signature").on_attach(require("viktor.config.plugin.lsp_signature"), bufnr) -- no need to specify bufnr if you don't use toggle_key

		require("lint").linters_by_ft = { cpp = { "cpplint" } }

		vim.keymap.set("n", "<leader>ef", function()
			vim.cmd(":setlocal foldmarker=#ifdef,#endif")
			vim.cmd(":set foldmethod=marker")
		end, opt)

		vim.keymap.set({ "n" }, "gs", function()
			require("lsp_signature").toggle_float_win()
		end, { buffer = bufnr, silent = true, noremap = true, desc = "toggle signature" })

		vim.keymap.set("n", "<leader>rb", function()
			vim.cmd("Task start cmake build")
		end, opt)

		vim.keymap.set("n", "<leader>rc", function()
			vim.cmd("Task start cmake configure")
		end, opt)

		vim.keymap.set("n", "<leader>rn", function()
			require("cpp_test").run_test(vim.fn.expand("%:p"))
		end, opt)

        vim.keymap.set('n', '<leader>cd', vim.diagnostic.setqflist, opt)

        opt["desc"] = "run function"
		vim.keymap.set("n", "<leader>rp", function()
			local file_relpath = vim.fn.expand("%:r")
			local executable = "./build/" .. file_relpath

			require("harpoon.tmux").sendCommand("!", 'echo; echo "RUN MAKE"; echo; ' .. "make -C build; " .. "\r")
			require("harpoon.tmux").sendCommand(
				"!",
				'echo; echo "Run Executable"; echo; ' .. executable .. "; " .. "\r"
			)
		end, opt)

	end,
	filetypes = { "c", "hpp", "cpp", "objc", "objcpp", "cuda", "proto" },
})
