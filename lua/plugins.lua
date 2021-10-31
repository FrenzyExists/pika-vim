
-- Btw, the config part is related to the plugins
return require('packer').startup(function(use, cmd)
    use 'wbthomason/packer.nvim'

    use 'frenzyexists/aquarium-vim'

    use 'norcalli/nvim-colorizer.lua'

    use {
        'lewis6991/gitsigns.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require 'plugins.gitsigns'
        end
    }

    use 'nvim-lua/plenary.nvim'

    use {
        'glepnir/dashboard-nvim',
        config = function()
            require 'plugins.dashboard'
        end
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require 'plugins.telescope'
        end
    }

  --  use 'SirVer/ultisnips'
    
end)
