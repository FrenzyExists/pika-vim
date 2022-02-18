-- Partly taken from LunarVim to adapt original vimscript bindings
local Pika = { }

-- Import this shit
local opt = vim.opt
local g = vim.g
local o = vim.o
local cmd = vim.cmd
-- Hoy voy a romper noche
Pika.settings = function()

    -- PikaVim Default Settings
    local defaults = {
        backup = false, -- Backups are for chumps!
        clipboard = "unnamedplus", -- Neovim plz access sys clipboard
        wrap = false, -- I hate softwrappning
        mouse = "a", -- allow the mouse to be used in neovim
        hidden = true,
        cmdheight = 1,
        cindent = false,
        backspace= "indent,eol,start", -- Fix Backspace
        termguicolors = true, -- Gui plz
        title = false, -- Who needs titles?
        spelllang = "en",
        swapfile = false, -- That's what she said
        smartindent = true, -- make indenting smarter again
        copyindent = true,
        preserveindent = true,
        smartcase = true, -- smart case
        showmode = false, -- Who the fuck needs this when we have a statusline?
        breakindent = true, -- Indent lines wrapped in the view
        linebreak = true, -- break lines in viewport at allowed characters only
        pumheight = 10, -- pop up menu height
        updatetime = 250, -- update interval for gitsigns
        fileencoding = "utf-8", -- the encoding written to a file
        incsearch = true, -- -- Incremental search
        conceallevel = 0, -- so that `` is visible in markdown files
        guifont = "Operator Mono:h15", -- the font used in graphical neovim applications
        timeoutlen = 250, -- time to wait for a mapped sequence to complete in ms
        writebackup = false, -- Backups are cringe
        relativenumber = false, -- set relative numbered lines
        numberwidth = 3, -- set number column width {default 4}
        foldmethod = "manual", -- folding, set to "expr" for treesitter based folding
        scrolloff = 10,
        tabpagemax= 50,
        wildmode= "longest:full,full", -- Commandline autocompletion
        sidescrolloff = 10,
        ignorecase = true, -- ignore case in search patterns
        errorbells = false, -- Take out annoying bell sound (kitty I'm watching you)
        hlsearch = false, -- No search highlight, who needs that?
        tabstop = 4, -- spaces for a tab
        shiftwidth = 4, -- the number of spaces inserted for each indentation
        splitbelow = true, -- force all horizontal splits to go below current window
        splitright = true, -- force all vertical splits to go to the right of current window
        undofile = true, -- enable persistent undo
        signcolumn = "yes", -- I hate this, but here it is
        expandtab = false,
        cul = true, -- Hightlight line, easier to spot
        tw = 76
    }

    local disabled_builtins = {
        "gzip",
        "zip",
        "zipPlugin",
        "getscript",
		"getscriptPlugin",
		"vimball",
		"vimballPlugin",
    }

	g.auto_save = false -- I save when I feel like

    opt.fillchars = {
        vert = "▕",
        fold = " ",
        eob = " ", -- -- No tilde on end of buffer
        diff = "─",
        msgsep = "‾",
        foldopen = "▾",
        foldclose = "▸",
        foldsep = "│",
    }

	-- Parse new defaults
	for k, v in pairs(defaults) do
		opt[k] = v
	end

	-- Parse disabled stuff
	for _, plugin in pairs(disabled_builtins) do
	    g["loaded_" .. plugin] = 1
	end
    g.aquarium_style = "dark"

	-- totally not stolen from Theory of Everything
	o.completeopt = "menuone,noselect"

	-- Don't show statusline on vimterm
	cmd [[ au TermOpen term://* setlocal nonumber laststatus=0 ]]
    --cmd("set guicursor=n-v-c-i-ci-ve-sm:blinkon1,i-ci-ve:hor100-iCursor,n:Cursor,v-c:-CursorIM")
    cmd("colorscheme aquarium") -- Set Colorscheme
	cmd "au ColorScheme * hi SignColumn ctermbg=none guibg=none guifg=none"
end

-- | A U T O C M D S | --

-- Te mire y tú me entendiste... baby ya estamos solos
Pika.autocmds = function()
    local g = vim.g
    local fn = vim.fn
    local cmd = vim.cmd
    local opt = vim.opt
    local exec = vim.api.nvim_exec

    -- Set min window height to 0
    cmd [[ set wmh=0 ]]

    -- Make room for minheight change
    cmd [[ set winheight=1 ]]

    -- Enter command mode faster
    cmd [[nnoremap ; :]]
    cmd [[vnoremap ; :]]

    -- Don't clear clipboard when exiting
    cmd [[autocmd VimLeave * call system("xsel -ib", getreg('+'))]]

    -- If no filetype/filename then set filetype to text
    cmd [[autocmd BufEnter * if expand('%') ==# '' | setfiletype text | endif]]
    cmd [[autocmd BufEnter * if &filetype ==# '' | setlocal filetype=text | endif]]

    cmd [[
    autocmd TermOpen * setlocal listchars= nonumber norelativenumber nocursorline
    autocmd TermOpen * startinsert
    autocmd BufLeave term://* stopinsert
    ]]

    -- remove whitespace on save
    cmd [[au BufWritePre * :%s/\s\+$//e]]

    -- set wildmenu
    cmd [[ set wildmenu ]]

    -- highlight on yank
    exec([[
    augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
    augroup end
    ]], false)
end

return Pika

