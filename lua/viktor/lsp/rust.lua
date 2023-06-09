local rust_tools = require("rust-tools")

local my_on_attach = function(client, bufnr)
	local opts = { silent = true, buffer = bufnr }

	pcall(function()
		vim.keymap.del("i", "<tab>")
	end)

	require("lsp_signature").on_attach(require("viktor.config.plugin.lsp_signature"), bufnr) -- no need to specify bufnr if you don't use toggle_key

	require("viktor.config.plugin.neotest").on_attach(client, bufnr)
	require("viktor.config.plugin.tasks").on_attach(client, bufnr)

	vim.o.foldmethod = "marker"

	vim.keymap.set("n", "<leader>ca", "<cmd>RustCodeAction<CR>", opts)

	-- "Goto FileType Config"
	vim.keymap.set("n", "'L", "<CMD>e ~/.config/nvim/lua/viktor/lsp/rust.lua<CR>", opts)
	vim.keymap.set("n", "'C", "<CMD>e ~/.config/nvim/after/plugin/cmp/rust.lua<CR>", opts)

	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "gk", function()
		vim.cmd("RustHoverActions")
	end, opts)
	vim.keymap.set("n", "gP", function()
		vim.cmd("RustParentModule")
	end, opts)

	vim.keymap.set("n", "<leader>cb", function()
		vim.cmd("Task start cargo build")
	end, opts)
	vim.keymap.set("n", "<leader>rb", function()
		vim.cmd("copen")
		vim.cmd("wincmd w")
		vim.cmd("silent make build")
	end, opts)

	vim.keymap.set("n", "<leader>ba", function()
		vim.cmd("Task start cargo build --all-features")
	end, opts)

	vim.keymap.set("n", "<leader>bg", function()
		vim.cmd("Task start cargo build --features google_bucket")
	end, opts)

	vim.keymap.set("n", "<leader>bt", function()
		vim.cmd("Task start cargo build --features read_tiff")
	end, opts)

	vim.keymap.set("n", "<leader>bb", function()
		vim.cmd("Task start cargo build --features bathymetry")
	end, opts)

	vim.keymap.set("n", "<leader>bf", function()
		vim.cmd("Task start cargo build --features forecast")
	end, opts)

	vim.keymap.set("n", "<leader>ct", function()
		vim.cmd("Task start cargo test")
	end, opts)

	vim.keymap.set("n", "<leader>rm", function()
		require("harpoon.tmux").sendCommand(
			"!",
			'maturin develop --cargo-extra-args="--features python-bindings"\r' .. "python3 main.py\r"
		)
	end, opts)

	-- vim.keymap.set("n", "<leader>rl", function()
	-- 	require("harpoon.tmux").sendCommand(
	-- 		"!",
	-- 		"\rcargo run --example get_boundaries_of_all_bathymetry_files --features='bathymetry examples'\r"
	-- 	)
	-- end, opts)
	-- vim.keymap.set("n", "<leader>rl", function()
	-- 	local example_name = vim.fn.expand("%:t:r")
	-- 	local features = require("rust_funcs").toml.get_required_features_for_ex(example_name)
	--
	-- 	require("harpoon.tmux").sendCommand(
	-- 		"!",
	-- 		"\rcargo run --example " .. example_name .. " --features=" .. table.concat(features, ",") .. "\r"
	-- 	)
	-- end, opts)
    vim.keymap.set("n", "<leader>rl", function()
        if vim.fn.expand("%:h") == "examples" then
            local ex_name = vim.fn.expand("%:t:r")
            vim.print(ex_name)
            require('harpoon.tmux').sendCommand("!", "\rcargo run --example "..ex_name .. "\r")
        else
	        local toml = require("rust_funcs").toml.read_configs()

            local targets = {}
            for _, tg in ipairs(toml.targets) do
                --- needs refactoring
                if tg.kind[1] == "bin" then
                    table.insert(targets, tg.name)
                end
            end

            if 1 < #targets then
                vim.ui.select(targets, { prompt = "Select" }, function(choice)
                    require('harpoon.tmux').sendCommand("!", "\rcargo run --bin "..choice .. "\r")
                end)
            else
                require('harpoon.tmux').sendCommand("!", "\rcargo run --bin "..targets[1] .. "\r")
            end
            print("no targets found")
        end

    end, opts)

	vim.keymap.set("n", "<leader>rk", function()
		vim.cmd("Task start cargo clippy --tests --features=all --examples")
	end, opts)

	vim.keymap.set("n", "<leader>rt", function()
		vim.cmd("copen")
		vim.cmd("wincmd w")
		vim.cmd("silent make test " .. vim.fn.expand("%"))
	end, opts)

	-- vim.keymap.set("n", "gk", "K", opts)

	-- vim.keymap.set("n", "gk", vim.lsp.buf.hover, {})
	vim.api.nvim_set_keymap("n", "gk", "K", {})

	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "<leader>cd", vim.diagnostic.setqflist, opts)

	vim.cmd("set colorcolumn=101")
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	local mappings = {
		["re"] = "RustEmitAsm",
		["rei"] = "RustEmitIr",
		["ree"] = "RustExpand",
		-- ["rf"] = "RustFmt",
		["rF"] = "RustFmtRange",
		-- ["ri"] = "RustSetInlayHints",
		-- ["ri"] = "RustToggleInlayHints",
		["rh"] = "RustHoverActions",
		-- ["rhr"] = "RustHoverRange",
		-- ["rj"] = "RustJoinLines",
		["rC"] = "RustOpenCargo",
		-- ["roc"] = "e Cargo.toml",
		-- ["roe"] = "RustOpenExternalDocs",
		-- ["rP"] = "RustPlay",
		["rrr"] = "RustRun",
		["rrR"] = "RustRunnables",
		["rrw"] = "RustReloadWorkspace",
		-- ["rC"] = "RustViewCrateGraph",
		-- ["rp"] = "RustParentModule",
	}
	for bind, cmd in pairs(mappings) do
		local _opts = opts
		_opts["desc"] = cmd
		vim.keymap.set("n", "<leader>" .. bind, function()
			vim.cmd(cmd)
		end, _opts)
	end

	local searches = require("rust_jump")

	vim.keymap.set(
		"n",
		"<leader>ja",
		"/" .. searches.all.both .. "<CR>:set nohlsearch<CR>",
		{ silent = true, buffer = bufnr }
	)

	vim.keymap.set(
		"n",
		"<leader>ji",
		"/" .. searches.impl.both .. "<CR>:set nohlsearch<CR>",
		{ silent = true, buffer = bufnr, desc = "impl" }
	)
	vim.keymap.set(
		"n",
		"<leader>js",
		"/" .. searches.struct.both .. "<CR>:set nohlsearch<CR>",
		{ silent = true, buffer = bufnr, desc = "struct" }
	)

	vim.keymap.set(
		"n",
		"<leader>jf",
		"/" .. searches.fn.both .. "<CR>:set nohlsearch<CR>",
		{ silent = true, buffer = bufnr, desc = "fn" }
	)
	vim.keymap.set(
		"n",
		"<leader>jn",
		"/" .. searches.fn.both .. "<CR>:set nohlsearch<CR>",
		{ silent = true, buffer = bufnr, desc = "fn" }
	)

	vim.keymap.set(
		"n",
		"<leader>jt",
		"/" .. searches.trait.both .. "<CR>:set nohlsearch<CR>",
		{ silent = true, buffer = bufnr, desc = "trait" }
	)
	vim.keymap.set(
		"n",
		"<leader>je",
		"/" .. searches.enum.both .. "<CR>:set nohlsearch<CR>",
		{ silent = true, buffer = bufnr, desc = "enum" }
	)
	vim.keymap.set(
		"n",
		"<leader>jm",
		"/" .. searches.mod_use.both .. "<CR>:set nohlsearch<CR>",
		{ silent = true, buffer = bufnr, desc = "mod_use" }
	)
	vim.keymap.set(
		"n",
		"<leader>jp",
		"/" .. searches.mod_pub.both .. "<CR>:set nohlsearch<CR>",
		{ silent = true, buffer = bufnr, desc = "mod_pub" }
	)

	-- VIMGREP
	-- both
	vim.keymap.set(
		"n",
		"<leader>gpa",
		'<CR>:vimgrep "' .. searches.all.pub .. '" ./src/**<CR>',
		{ silent = true, buffer = bufnr, desc = "all" }
	)
	vim.keymap.set(
		"n",
		"<leader>gpi",
		'<CR>:vimgrep "' .. searches.impl.pub .. '" ./src/**<CR>',
		{ silent = true, buffer = bufnr, desc = "impl" }
	)
	vim.keymap.set(
		"n",
		"<leader>gps",
		'<CR>:vimgrep "' .. searches.struct.pub .. '" ./src/**<CR>',
		{ silent = true, buffer = bufnr, desc = "struct" }
	)
	vim.keymap.set(
		"n",
		"<leader>gpf",
		'<CR>:vimgrep "' .. searches.fn.pub .. '" ./src/**<CR>',
		{ silent = true, buffer = bufnr, desc = "fn" }
	)
	vim.keymap.set(
		"n",
		"<leader>gpn",
		'<CR>:vimgrep "' .. searches.fn.pub .. '" ./src/**<CR>',
		{ silent = true, buffer = bufnr, desc = "fn" }
	)
	vim.keymap.set(
		"n",
		"<leader>gpt",
		'<CR>:vimgrep "' .. searches.trait.pub .. '" ./src/**<CR>',
		{ silent = true, buffer = bufnr, desc = "trait" }
	)
	vim.keymap.set(
		"n",
		"<leader>gpe",
		'<CR>:vimgrep "' .. searches.enum.pub .. '" ./src/**<CR>',
		{ silent = true, buffer = bufnr, desc = "enum" }
	)
	vim.keymap.set(
		"n",
		"<leader>gpm",
		'<CR>:vimgrep "' .. searches.mod_use.pub .. '" ./src/**<CR>',
		{ silent = true, buffer = bufnr, desc = "mod_use" }
	)
	-- vim.keymap.set("n", "<leader>gpp", '<CR>:vimgrep "'..searches.mod_pub.pub..'" ./src/**<CR>', {silent = true, buffer = bufnr, desc = "mod_pub"})
	-- pub
	vim.keymap.set(
		"n",
		"<leader>ga",
		'<CR>:vimgrep "' .. searches.all.both .. '" ./src/**<CR>',
		{ silent = true, buffer = bufnr, desc = "all" }
	)
	vim.keymap.set(
		"n",
		"<leader>gi",
		'<CR>:vimgrep "' .. searches.impl.both .. '" ./src/**<CR>',
		{ silent = true, buffer = bufnr, desc = "impl" }
	)
	vim.keymap.set(
		"n",
		"<leader>gs",
		'<CR>:vimgrep "' .. searches.struct.both .. '" ./src/**<CR>',
		{ silent = true, buffer = bufnr, desc = "struct" }
	)
	vim.keymap.set(
		"n",
		"<leader>gf",
		'<CR>:vimgrep "' .. searches.fn.both .. '" ./src/**<CR>',
		{ silent = true, buffer = bufnr, desc = "fn" }
	)
	vim.keymap.set(
		"n",
		"<leader>gn",
		'<CR>:vimgrep "' .. searches.fn.both .. '" ./src/**<CR>',
		{ silent = true, buffer = bufnr, desc = "fn" }
	)
	vim.keymap.set(
		"n",
		"<leader>gt",
		'<CR>:vimgrep "' .. searches.trait.both .. '" ./src/**<CR>',
		{ silent = true, buffer = bufnr, desc = "trait" }
	)
	vim.keymap.set(
		"n",
		"<leader>ge",
		'<CR>:vimgrep "' .. searches.enum.both .. '" ./src/**<CR>',
		{ silent = true, buffer = bufnr, desc = "enum" }
	)
	vim.keymap.set(
		"n",
		"<leader>gm",
		'<CR>:vimgrep "' .. searches.mod_use.both .. '" ./src/**<CR>',
		{ silent = true, buffer = bufnr, desc = "mod_use" }
	)
	-- vim.keymap.set("n", "<leader>gp", '<CR>:vimgrep "'..searches.mod_pub.both..'" ./src/**<CR>', {silent = true, buffer = bufnr, desc = "mod_pub"})

	opts["desc"] = "Goto Parent Module"

	vim.keymap.set("n", "gp", function()
		vim.cmd("RustParentModule")
	end, opts)

	vim.keymap.set("n", "<leader>rP", function()
		vim.cmd("RustParentModule")
	end, opts)

	opts["desc"] = "Run Program in last terminal"

	vim.keymap.set("n", "<leader>rp", require("rust_funcs").cargo_run, opts)

	-- vim.keymap.set("n", "<leader>rl", require('rust_funcs').cargo_run_last, opts)
	vim.keymap.set("n", "<leader>ri", require("rust_funcs").toggle_inlay_hints, opts)

	-- local async = require('plenary.async')
	-- vim.keymap.set("n", "<leader>ri", function()
	--     async.run(require('rust_funcs.list_implementations').letsgo, function() end)
	-- end, opts)

	vim.cmd("compiler cargo")
end

local function _get_capabilites()
	-- local out = vim.lsp.protocol.make_client_capabilities()
	-- out = require('cmp_nvim_lsp').update_capabilities(capabilities)
	local out = require("cmp_nvim_lsp").default_capabilities()
	out.textDocument.completion.completionItem.snippetSupport = false
	return out
end

rust_tools.setup({
	server = {
		capabilities = _get_capabilites(),
		on_attach = my_on_attach,
		settings = {
			["rust-analyzer"] = {
				cargo = {
					autoReload = true,
					-- features = {
					-- 	"all",
					-- 	"gcloud_bucket",
					-- 	-- "read_tiff",
					-- 	-- "bathymetry",
					-- 	-- "forecast",
					-- 	-- "server",
					-- 	-- "examples"
					-- 	-- "gcloud_bucket",
					-- 	-- "read-tiff",
					-- 	-- "bathymetry",
					-- 	-- "pathfinding",
					-- 	-- "write",
					-- 	-- "python-bindings",
					-- },
				},
				-- interpret = {
				--     tests = true
				-- },

				procMacro = {
					enable = false,
				},
				diagnostics = {
					enable = true,
					disabled = { "unresolved-proc-macro" },
				},
				check = {
					command = "clippy",
					extraArgs = {
						"--tests",
						"--example temp",
						"--features=all",
					},
				},
				-- checkOnSave = {
				-- 	command = "clippy",
				-- },
			},
		},
		filetypes = { "rust", "rs" },
		checkOnSave = {
			enable = true,
		},
		server = {
			cmd = "rust-analyzer",
			-- cmd = "nice --10 rust-analyzer",
		},
		handlers = {
			-- vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
			-- vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })
			["textDocument/hover"] = require("vim.lsp").with(vim.lsp.handlers.hover, {
				-- border = "single",
				border = "rounded",
				width = 80,
			}),
			-- ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
		},
	},
})

-- Commands:
-- RustEnableInlayHints
-- RustDisableInlayHints
-- RustSetInlayHints
-- RustUnsetInlayHints

-- Set inlay hints for the current buffer
rust_tools.inlay_hints.set()
-- Unset inlay hints for the current buffer
rust_tools.inlay_hints.unset()

-- Enable inlay hints auto update and set them for all the buffers
rust_tools.inlay_hints.enable()
-- Disable inlay hints auto update and unset them for all buffers
rust_tools.inlay_hints.disable()
