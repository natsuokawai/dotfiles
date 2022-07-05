local api = vim.api

------------------------------
-- basic options
------------------------------
vim.o.hidden = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 300
vim.bo.autoindent = true
vim.bo.autoread = true
vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.smartindent = true
vim.bo.tabstop = 2
vim.wo.cursorline = true
vim.wo.number = true
vim.cmd 'lan en_US.UTF-8'
vim.cmd 'set clipboard+=unnamedplus'

------------------------------
-- key mappings
------------------------------
vim.g.mapleader = ' '
api.nvim_set_keymap('n', '<C-N>', ':bnext<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<C-P>', ':bnext<CR>', { noremap = true, silent = true })

------------------------------
-- dein.vim settings
------------------------------
local dein_dir = vim.fn.expand('~/.cache/dein')
local dein_repo_dir = dein_dir..'/repos/github.com/Shougo/dein.vim'

vim.o.runtimepath = dein_repo_dir..','..vim.o.runtimepath

-- dein install check
if (vim.fn.isdirectory(dein_repo_dir) == 0) then
  os.execute('git clone https://github.com/Shougo/dein.vim '..dein_repo_dir)
end

-- begin settings
if (vim.fn['dein#load_state'](dein_dir) == 1) then
  local rc_dir = vim.fn.expand('~/.config/nvim')
  local toml = rc_dir..'/dein.toml'
  vim.fn['dein#begin'](dein_dir)
  vim.fn['dein#load_toml'](toml, { lazy = 0 })
  vim.fn['dein#end']()
  vim.fn['dein#save_state']()
end

-- plugin install check
if (vim.fn['dein#check_install']() ~= 0) then
  vim.fn['dein#install']()
end

-- plugin remove check
local removed_plugins = vim.fn['dein#check_clean']()
if vim.fn.len(removed_plugins) > 0 then
  vim.fn.map(removed_plugins, "delete(v:val, 'rf')")
  vim.fn['dein#recache_runtimepath']()
end
