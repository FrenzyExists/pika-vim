-- Btw, the config part is related to the plugins
return require('packer').startup(function(use)
    local opt = vim.opt
    local g = vim.g
    local o = vim.o
    local cmd = vim.cmd

    use 'wbthomason/packer.nvim'
    use 'rafamadriz/friendly-snippets'
    use '/home/pikachu/Documents/Projects/vim-projects/aquarium-vim'
    use {
        'L3MON4D3/LuaSnip',
        config = function() require 'plugins.cmp' end
    }
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use {
        'hrsh7th/nvim-cmp',
        config = function()
            require 'plugins.completion'
        end
    }

    use 'tpope/vim-fugitive'
   use {
        'neovim/nvim-lspconfig',
        config = function()
            local lsp_installer = require("nvim-lsp-installer")

            lsp_installer.on_server_ready(function(server)
                local opts = {}

                server:setup(opts)
            end)
        end
    }

    use 'williamboman/nvim-lsp-installer'

    use {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require 'plugins.treesitter'
        end
    }

    use {
        'nvim-orgmode/orgmode',
        config = function() require 'plugins.orgmode' end
    }

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

