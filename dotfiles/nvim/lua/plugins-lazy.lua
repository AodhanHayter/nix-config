local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Install lazy.nvim if not already installed
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
    {
        "trevordmiller/nova-vim",
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme nova]])
            vim.cmd([[highlight clear SignColumn]])
        end
    },
    { "numToStr/Comment.nvim", lazy = false, name = "Comment", config = true },
    { "windwp/nvim-autopairs", lazy = false,  config = function() require("nvim-autopairs").setup() end },
    { "tmhedberg/matchit", lazy = false },
    { "tpope/vim-surround", lazy = false },
    { "tpope/vim-endwise", lazy = false },
    { "ojroques/nvim-hardline", lazy = false },
    { "norcalli/nvim-colorizer.lua", lazy = false },
    { "junegunn/vim-slash", lazy = false },
    { "sheerun/vim-polyglot", lazy = false },
    {
        "nvim-tree/nvim-tree.lua",
        lazy = false,
        config = function()
            require('nvim-tree').setup({
                view = { side = "right" }
            })
        end,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        tag = "nightly"
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = { "neovim/nvim-lspconfig", "hrsh7th/cmp-nvim-lsp",  "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline"},
        config = function()
            local cmp = require("cmp")

            cmp.setup({
              sources = cmp.config.sources({
                { name = "nvim_lsp" },
              }, {
                { name = "buffer" },
              })
            })
        end
    },
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    { "lewis6991/gitsigns.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    "tpope/vim-fugitive",
    "ellisonleao/glow.nvim",
    { "iamcco/markdown-preview.nvim", build = "cd app && npm install", ft = "markdown", config = function() vim.g.mkdp_filetypes = { "markdown" } end},
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate"}
  })

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require('lspconfig')['tsserver'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities
}
