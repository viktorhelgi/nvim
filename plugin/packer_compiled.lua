-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "C:\\Users\\Lenovo\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\share\\lua\\5.1\\?.lua;C:\\Users\\Lenovo\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\share\\lua\\5.1\\?\\init.lua;C:\\Users\\Lenovo\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\luarocks\\rocks-5.1\\?.lua;C:\\Users\\Lenovo\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\luarocks\\rocks-5.1\\?\\init.lua"
local install_cpath_pattern = "C:\\Users\\Lenovo\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\lua\\5.1\\?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  Alduin = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\Alduin",
    url = "https://github.com/AlessandroYorba/Alduin"
  },
  ["aerial.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\aerial.nvim",
    url = "https://github.com/stevearc/aerial.nvim"
  },
  ["bluewery.vim"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\bluewery.vim",
    url = "https://github.com/relastle/bluewery.vim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-ultisnips"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmp-nvim-ultisnips",
    url = "https://github.com/quangnguyen30192/cmp-nvim-ultisnips"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["dashboard-nvim"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\dashboard-nvim",
    url = "https://github.com/glepnir/dashboard-nvim"
  },
  ["diffview.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\diffview.nvim",
    url = "https://github.com/sindrets/diffview.nvim"
  },
  everforest = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\everforest",
    url = "https://github.com/sainnhe/everforest"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  gruvbox = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\gruvbox",
    url = "https://github.com/morhetz/gruvbox"
  },
  ["gruvbox-material"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\gruvbox-material",
    url = "https://github.com/sainnhe/gruvbox-material"
  },
  harpoon = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\harpoon",
    url = "https://github.com/ThePrimeagen/harpoon"
  },
  ["hop.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\hop.nvim",
    url = "https://github.com/phaazon/hop.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  melange = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\melange",
    url = "https://github.com/savq/melange"
  },
  ["monokai.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\monokai.nvim",
    url = "https://github.com/tanvirtin/monokai.nvim"
  },
  neoformat = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\neoformat",
    url = "https://github.com/sbdchd/neoformat"
  },
  ["night-owl.vim"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\night-owl.vim",
    url = "https://github.com/haishanh/night-owl.vim"
  },
  ["nord.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nord.nvim",
    url = "https://github.com/shaunsingh/nord.nvim"
  },
  ["nvcode-color-schemes.vim"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvcode-color-schemes.vim",
    url = "https://github.com/ChristianChiarulli/nvcode-color-schemes.vim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-bqf"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-bqf",
    url = "https://github.com/kevinhwang91/nvim-bqf"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-comment"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-comment",
    url = "https://github.com/terrortylor/nvim-comment"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-pytrize.lua"] = {
    config = { 'require("pytrize").setup()' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\nvim-pytrize.lua",
    url = "https://github.com/AckslD/nvim-pytrize.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["onedark.vim"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\onedark.vim",
    url = "https://github.com/joshdick/onedark.vim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["rust-analyzer"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\rust-analyzer",
    url = "https://github.com/rust-lang/rust-analyzer"
  },
  ["rust-tools.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\rust-tools.nvim",
    url = "https://github.com/simrat39/rust-tools.nvim"
  },
  ["tabline.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\tabline.nvim",
    url = "https://github.com/kdheepak/tabline.nvim"
  },
  ["telescope-file-browser.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\telescope-file-browser.nvim",
    url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-projectionist"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-projectionist",
    url = "https://github.com/tpope/vim-projectionist"
  },
  ["vim-python-pep8-indent"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-python-pep8-indent",
    url = "https://github.com/Vimjas/vim-python-pep8-indent"
  },
  ["vim-rust-syntax-ext"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\vim-rust-syntax-ext",
    url = "https://github.com/arzg/vim-rust-syntax-ext"
  },
  ["vim-test"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-test",
    url = "https://github.com/vim-test/vim-test"
  },
  ["which-key.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Lenovo\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType py ++once lua require("packer.load")({'nvim-pytrize.lua'}, { ft = "py" }, _G.packer_plugins)]]
vim.cmd [[au FileType rs ++once lua require("packer.load")({'vim-rust-syntax-ext'}, { ft = "rs" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
