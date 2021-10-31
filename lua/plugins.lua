
-- Btw, the config part is related to the plugins
return require('packer').startup(function(use, cmd)
    use 'wbthomason/packer.nvim'

    use 'frenzyexists/aquarium-vim'

    use 'norcalli/nvim-colorizer.lua'

    use {
        'lewis6991/gitsigns.nvim',
        requires = 'nvim-lua/plenary.nvim',
    }

    use 'nvim-lua/plenary.nvim'
    
end)
