vim.o.pumblend = 0
vim.o.winblend = 0

local lsp_servers = {
    pyright =  "pyright",
    ruff_lsp = "ruff-lsp",
	-- pylsp = 'pylsp',
	godot = 'godot',
	lua = 'lua-language-server',
	cpp = 'clangd',
}

for server_name, lsp_executable in pairs(lsp_servers) do
	if vim.fn.executable(lsp_executable) == 1 then
		vim.lsp.enable(server_name)
	end
end

-- vim.g.python_host_prog='/home/viktorhg/.local/share/hatch/env/virtual/hefringdata/UHrmTeWw/migrate/bin/python3'
require('viktor')

require('fidget').setup({})

-- src/pathfinding/evaluate.rs
-- src/pathfinding/run.rs
-- src/pathfinding/astar/mod.rs
-- src/pathfinding/astar/get_successive_nodes.rs
-- src/pathfinding/post_processing.rs

-- src/pathfinding/evaluate.rs
-- src/pathfinding/run.rs
-- src/pathfinding/astar/mod.rs
-- src/pathfinding/astar/get_successive_nodes.rs
-- src/geos/grid/base.rs
-- src/geos/raster/base_2dim.rs
--

-- bin/http_server.rs
-- src/pathfinding/evaluate.rs
-- src/pathfinding/check_if_path_exists.rs
-- src/pathfinding/flood_fill/mod.rs
-- src/pathfinding/process_logger.rs
-- src/pathfinding/run.rs
-- src/server/firestore/client.rs
-- src/forecast/error.rs

-- src/gcloud_bucket/client.rs
-- src/data_manager/client/mod.rs
-- src/data_manager/client/downloader/mod.rs
-- src/data_manager/client/uploader/mod.rs
-- src/server/firestore/client.rs
-- vim.cmd('colorscheme nightfox')
