local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- My plugins here
  -------------------

  -- colorscheme
  use {
    'trevordmiller/nova-vim',
    config = function()
      vim.cmd('colorscheme nova')
      vim.cmd('highlight clear SignColumn')
    end
  }

  use {
    'kyazdani42/nvim-web-devicons',
     config = function() require('nvim-web-devicons').setup({}) end
  }

  use {
    'ojroques/nvim-hardline',
    config = function() require('hardline').setup({}) end
  }

  use {
    'norcalli/nvim-colorizer.lua',
    config = function() require('colorizer').setup({}) end
  }

  -- buffer search
  use 'junegunn/vim-slash'

  -- syntax
  use {'sheerun/vim-polyglot'}
  -- use {
  --   'nvim-treesitter/nvim-treesitter',
  --   branch = '0.5-compat',
  --   run = ':TSUpdate'
  -- }

  use {
    'windwp/nvim-autopairs',
    config = function() require('nvim-autopairs').setup({}) end
  }

  use 'tmhedberg/matchit'
  use 'tpope/vim-surround'


  -- file explorer
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require('nvim-tree').setup({}) end
  }

  -- fuzzy finder
  use { 'nvim-telescope/telescope.nvim',
    requires = {{ 'nvim-lua/plenary.nvim'}}
  }

  -- git
  use {
    'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function() require('gitsigns').setup({}) end
  }

  use 'tpope/vim-fugitive'

  -- comments
  use {
    'numToStr/Comment.nvim',
    config = function() require('Comment').setup() end
  }

  -- linting
  use { 'dense-analysis/ale' }

  -- javascript
  use 'David-Kunz/jester' -- for running jest tests

  -- markdown
  use 'ellisonleao/glow.nvim'


 -- R
 use { 'jalvesaq/Nvim-R', branch = 'stable' }

   -- } language server
 use { 'neoclide/coc.nvim', branch = 'release'}

 -- use {
 --   'folke/lsp-colors.nvim',
 --    config = function() require('lsp-colors').setup({
 --      Error = "#db4b4b",
 --      Warning = "#e0af68",
 --      Information = "#0db9d7",
 --      Hint = "#10B981"
 --    }) end
 -- }
 -- use 'neovim/nvim-lspconfig'
 -- use { 'ms-jpq/coq_nvim', {branch='coq'}}
 -- use {'ms-jpq/coq.artifacts', {branch='artifacts'}}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

