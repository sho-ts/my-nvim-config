--------------------------------
-- config
--------------------------------
-- ターミナルの真の色を有効化
vim.opt.termguicolors = true
vim.opt.winblend = 0 -- ウィンドウの不透明度
vim.opt.pumblend = 0 -- ポップアップメニューの不透明度

-- 行番号を表示
vim.opt.number = true

-- タブとインデントの設定
vim.opt.expandtab = true     -- タブをスペースに変換
vim.opt.tabstop = 2          -- タブ幅を2に設定
vim.opt.shiftwidth = 2       -- 自動インデントの幅を2に設定

-- 背景の透明化
vim.cmd [[
  hi Normal guibg=NONE ctermbg=NONE
  hi NonText guibg=NONE ctermbg=NONE
]]

vim.env.TERM = 'xterm-256color'
---------------------------------

---------------------------------
-- plugin
---------------------------------
vim.call('plug#begin')

vim.fn['plug#']('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
vim.fn['plug#']('folke/tokyonight.nvim')
vim.fn['plug#']('preservim/nerdtree')
vim.fn['plug#']('neoclide/coc.nvim', { branch = 'release' })

vim.call('plug#end')
---------------------------------

vim.api.nvim_create_user_command(
  'Format',
  function()
    vim.fn.CocAction('format')
  end,
  { nargs = 0 }
)

vim.api.nvim_set_keymap('n', 'K', ":call CocActionAsync('doHover')<CR>", { noremap = true, silent = true })

---------------------------------
-- plugin config
---------------------------------
require("tokyonight").setup({
  transparent = true,
})
vim.cmd[[colorscheme tokyonight]]

-- Treesitterの設定
require('nvim-treesitter.configs').setup {
  ensure_installed = { "typescript", "javascript", "tsx" }, -- 必要な言語を指定
  highlight = {
    enable = true, -- 構文ハイライトを有効にする
  },
}

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      vim.cmd("NERDTree")
    end
  end,
})

-- 既存の<D-y>マッピングを解除
pcall(vim.api.nvim_del_keymap, 'i', '<D-y>')

-- <D-y>でcocの補完候補を確定
vim.api.nvim_set_keymap('i', '<D-y>', 'coc#pum#visible() ? coc#pum#confirm() : "\\<D-y>"', { noremap = true, expr = true, silent = true })

-- InsertモードでCtrl + jをESCにマッピング
vim.api.nvim_set_keymap('i', '<C-j>', '<ESC>', { noremap = true, silent = true })
---------------------------------
