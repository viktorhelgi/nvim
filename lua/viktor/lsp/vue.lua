-- require('vue-goto-definition').goto_definition({
-- 	filters = {
-- 		auto_imports = true, -- resolve definitions in auto-imports.d.ts
-- 		auto_components = true, -- resolve definitions in components.d.ts
-- 		import_same_file = true, -- filter location list entries referencing an
-- 		-- import in the current file.  See below for details
-- 		declaration = true, -- filter declaration files unless the only location list
-- 		-- item is a declaration file
-- 		duplicate_filename = true, -- dedupe duplicate filenames
-- 	},
-- 	filetypes = { 'vue', 'typescript' }, -- enabled for filetypes
-- 	detection = { -- framework detection.  Detection functions can be overridden here
-- 		nuxt = function() -- look for .nuxt directory
-- 			return vim.fn.glob('.nuxt/') ~= ''
-- 		end,
-- 		vue3 = function() -- look for vite.config.ts or App.vue
-- 			return vim.fn.filereadable('vite.config.ts') == 1 or vim.fn.filereadable('src/App.vue') == 1
-- 		end,
-- 		priority = { 'nuxt', 'vue3' }, -- order in which to detect framework
-- 	},
-- 	lsp = {
-- 		override_definition = true, -- override vim.lsp.buf.definition
-- 	},
-- 	debounce = 200,
-- })
--
-- If you are using mason.nvim, you can get the ts_plugin_path like this
-- local mason_registry = require('mason-registry')
-- local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server'

local lspconfig = require('lspconfig')

lspconfig.tsserver.setup({
	init_options = {
		plugins = {
			{
				name = '@vue/typescript-plugin',
				location = '/home/viktorhg/.local/share/nvim/mason/bin/vue-language-server',
				languages = { 'vue' },
			},
		},
	},
	filetypes = {
		'typescript',
		'javascript',
		'javascriptreact',
		'typescriptreact',
		'vue',
	},
})

-- -- No need to set `hybridMode` to `true` as it's the default value
-- lspconfig.volar.setup({})
