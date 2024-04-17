require 'options'
require 'keymap'
require 'autocommands'
require 'yank'
require 'lazyinstall'

-- [[ Configure and install plugins ]]
require('lazy').setup({
  { import = 'plugins' },
  -- Rose pine theme
  {
    'rose-pine/neovim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd [[ colorscheme rose-pine-main ]]
    end,
  },
}, require 'lazyconfig')

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
