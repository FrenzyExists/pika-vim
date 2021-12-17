-- Btw, the config part is related to the plugins
return require('packer').startup(function(use)
    local opt = vim.opt
    local g = vim.g
    local o = vim.o
    local cmd = vim.cmd

    use 'wbthomason/packer.nvim'

    use 'frenzyexists/aquarium-vim'

    use 'norcalli/nvim-colorizer.lua'

 --   use {
 --       'lewis6991/gitsigns.nvim',
 --       requires = 'nvim-lua/plenary.nvim',
 --       config = function()
 --           require 'plugins.gitsigns'
 --       end
 --   }

    --use 'nvim-lua/plenary.nvim'

    use {
        'glepnir/dashboard-nvim',
        config = function()
            require 'plugins.dashboard'
        end
    }

  --  use {
  --      'nvim-telescope/telescope.nvim',
  --      requires = 'nvim-lua/plenary.nvim',
  --      config = function()
  --          require 'plugins.telescope'
  --      end
  --  }

 --   use {
 --       'folke/which-key.nvim',
 --       config = function() require("which-key").setup {} end
 --   }

    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'FrenzyExists/nvim-web-devicons',
        config = function() require'nvim-tree'.setup {} end
    }

 --   use 'antoinemadec/FixCursorHold.nvim'

 --   use {
 --       "akinsho/toggleterm.nvim",
 --       config = function() require("toggleterm").setup {} end
 --   }

 --   use {
 --       'kristijanhusak/orgmode.nvim', 
 --       branch = 'tree-sitter',
 --       config = function() require('orgmode').setup {} end
 --   }

    use 'FrenzyExists/nvim-web-devicons'

--    use {
--        'numToStr/Comment.nvim',
--        config = function() require('Comment').setup {} end
--    }

  --  use 'SirVer/ultisnips'
end)
