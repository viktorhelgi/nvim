
M = {}

M.setup_server = function(client, bufnr)
    local black = require("viktor/efm/black")
    local isort = require("viktor/efm/isort")
    local flake8 = require("viktor/efm/flake8")
    local mypy = require("viktor/efm/mypy")

    require "lspconfig".efm.setup {
        init_options = { documentFormatting = true },
        root_dir = vim.loop.cwd,
        filetype = { "python" },
        on_attach = function()
            local opts = { noremap = true, silent = false }
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lf', '<cmd>Format<CR>', opts)
        end,
        settings = {
            rootMarkers = { ".git/" },
            languages = {
                lua = {
                    { formatCommand = "lua-format -i", formatStdin = true }
                },
                python = { black, isort, flake8, mypy }
            }
        }
    }
end
return M
