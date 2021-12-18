-- Btw, the config part is related to the plugins
return require('packer').startup(function(use)
    local opt = vim.opt
    local g = vim.g
    local o = vim.o
    local cmd = vim.cmd

    use 'wbthomason/packer.nvim'

    use '/home/pikachu/Documents/Projects/vim-projects/aquarium-vim'

    use '/home/pikachu/Documents/Projects/vim-projects/uwu.vim'

   -- use {
   --     'neovim/nvim-lspconfig',
   --     config = function()
   --         require 'plugins.lspconfig'
   --     end
   -- }

    use 'norcalli/nvim-colorizer.lua'

    -- use "lukas-reineke/indent-blankline.nvim"

    use {
        'glepnir/dashboard-nvim',
        config = function()
            require 'plugins.dashboard'
        end
    }

    use {
        'lewis6991/gitsigns.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require 'plugins.gitsigns'
        end
    }
    use '~/Documents/Projects/lua-projects/dashy-lua'

    use {
        "akinsho/toggleterm.nvim",
        config = function()
            require 'plugins.termboi'
        end
    }

    use 'kyazdani42/nvim-web-devicons'

	use { '~/Documents/Projects/lua-projects/feline.nvim',
    config = function() require 'plugins.feline' end }

    use 'Manas140/run.nvim'

    use {
    'kyazdani42/nvim-tree.lua',
    requires = {'kyazdani42/nvim-web-devicons',},
    config = function() require'nvim-tree'.setup {} end }

    use 'justinmk/vim-sneak'

end)

