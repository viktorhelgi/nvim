
local M = {}

function M.setup_folding()
  vim.api.nvim_command("augroup filetype_snippets")
  vim.api.nvim_command("autocmd!")
  vim.api.nvim_command("autocmd FileType snippets setlocal foldmethod=marker")
  vim.api.nvim_command("autocmd FileType snippets setlocal foldmarker=snippet,endsnippet")
  vim.api.nvim_command("augroup END")
end

return M
