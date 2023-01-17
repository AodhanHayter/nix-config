local o = vim.o
local opt = vim.opt
local wo = vim.wo
local bo = vim.bo
local cmd = vim.cmd

-- global options
o.termguicolors = true
o.guicursor = 'i-ci-ve:hor100'
o.path = o.path .. ',**'
o.cmdheight = 2
o.showmode = false
o.hidden = true
o.mouse = 'a'
o.updatetime = 300
o.showmatch = true
o.clipboard = 'unnamedplus'
opt.shortmess = opt.shortmess + { ['c'] = true }
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true
opt.undofile = true
opt.listchars = { tab = '>~', trail = '·'}

-- window-local options
wo.number = true
wo.relativenumber = true
wo.wrap = false
wo.list = true
wo.signcolumn = 'auto:2'

-- buffer-local options
bo.tabstop = 2
bo.shiftwidth = 2
bo.expandtab = true
bo.smartindent = true
bo.autoindent = true
bo.undofile = true

cmd('syntax enable')


-- autocmds
------------
cmd('au InsertEnter * set cul')
cmd('au InsertLeave * set nocul')
cmd('au BufWritePre * :%s/\\s\\+$//e') -- remove whitespace on save
cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])


-- globals
-----------
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- autocomplete
-- vim.g.coq_settings = {
--   auto_start = 'shut-up',
--   limits = {
--     completion_manual_timeout = 500
--   }
-- }

-- ALE settings
vim.g.ale_virtualtext_cursor = 1
vim.g.ale_disable_lsp = 1
vim.g.ale_completion_enabled = 0
vim.g.ale_javascript_prettier_options = '--prose-wrap always'
vim.g.ale_fixers = {
  html = {'prettier'},
  css = {'prettier'},
  javascript = {'prettier'},
  less = {'prettier'},
  markdown = {'prettier'},
  typescript = {'prettier'},
  typescriptreact = {'prettier'},
  sql = {'pgformatter'}
  }
