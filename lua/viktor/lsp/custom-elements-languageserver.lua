
require'lspconfig'.custom_elements_ls.setup{
	on_attach = function(client, bufnr)
        client.server_capabilities = {
          codeActionProvider = true,
          completionProvider = vim.empty_dict(),
          -- declarationProvider = true,
          -- definitionProvider = true,
          hoverProvider = true,
          referencesProvider = true,
          textDocumentSync = {
            change = 1,
            openClose = true,
            save = {
              includeText = false
            },
            willSave = false,
            willSaveWaitUntil = false
          },
          workspace = {
            workspaceFolders = {
              supported = true
            }
          }
        }

        -- vim.print(client.server_capabilities)
		-- client.server_capabilities = require('viktor.lsp.capabilities.pyright')
		-- on_attach(client, bufnr)
	end,
}
