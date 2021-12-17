--[[
* Commands                  Mode
* ----------------------    -----------------------
* nmap, nnoremap, nunmap    Normal mode
* imap, inoremap, iunmap    Insert and Replace mode
* vmap, vnoremap, vunmap    Visual and Select mode
* xmap, xnoremap, xunmap    Visual mode
* smap, snoremap, sunmap    Select mode
* cmap, cnoremap, cunmap    Command-line mode
* omap, onoremap, ounmap    Operator pending mode
]]--
-- Function taken from NvimChad
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Don't copy the replaced text after pasting in visual mode
map("v", "p", '"_dP', opt)

-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- empty mode is same as using :map
map("", "j", 'v:count ? "j" : "gj"', {expr = true})
map("", "k", 'v:count ? "k" : "gk"', {expr = true})
map("", "<Down>", 'v:count ? "j" : "gj"', {expr = true})
map("", "<Up>", 'v:count ? "k" : "gk"', {expr = true})

-- Tab Movement
map("", "<C-w>", ":tabprevious<CR>", opt)
map("", "<C-e>", ":tabnext<CR>", opt)
map("", "<C-t>", ":tabnew<CR>", opt)
map("", "<C-y>", ":tabclose<CR>", opt)

-- Save with ctrl+s, like every normal damn editor
map("n", "<C-s>", ":w<CR>", opt)
map("n", "<C-S-s>", ":wq<CR>", opt) -- for some reason this aint working

-- Split faster (fast as fuck boi)
map("n", "<leader>\\", ":vs<CR>", opt)
map("n", "<leader>-", ":sp<CR>", opt)

-- Move between each split faster (speed, I am speed)
map("", "<C-k>", "<C-w>k", opt)
map("", "<C-j>", "<C-w>j", opt)
map("", "<C-l>", "<C-w>l", opt)
map("", "<C-h>", "<C-w>h", opt)

-- Open Terminals

-- term over right
map("n", "<C-x>", ":vnew +terminal | setlocal nobuflisted <CR>", opt)
--  term bottom
map("n", "<C-b>", ":10new +terminal | setlocal nobuflisted <CR>", opt)
-- term buffer
map("n", "<C-S-b>", ":terminal <CR>", opt)

-- move the current line/block with Alt-j/k ala VSCode (INSERT)
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opt)
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opt)

-- move the current line/block with Alt-j/k ala VSCode (VISUAL)
map("v", "<A-j>", ":m '>+1<CR>gv-gv", opt)
map("v", "<A-k>", ":m '<-2<CR>gv-gv", opt)

-- Better Resizing ala LunarVim
map("n", "<C-Up>", ":resize -2<CR>", opt)
map("n", "<C-Down>", ":resize +2<CR>", opt)
map("n", "<C-Left>", ":vertical +2<CR>", opt)
map("n", "<C-Right>", ":vertical -2<CR>", opt)

-- navigation ala LunarVim
-- map("i", "<A-Up>", "C-\\><C-N><C-w>k", opt)
-- map("i", "<A-Down>", "C-\\><C-N><C-w>j", opt)
-- map("i", "<A-Left>", "C-\\><C-N><C-w>h", opt)
-- map("i", "<A-Right>", "C-\\><C-N><C-w>l", opt)

-- navigate over tab completion ala LunarVim
-- Yes I am stealing, shut the fuck off
map("i", "<C-j>", 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = false })
map("i", "<C-k>", 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = false })

-- copy whole file content
map("n", "<C-a>", ":%y+<CR>", opt)

-- toggle numbers
map("n", "<leader>_", ":set nu!<CR>", opt)

-- use ESC to turn off search highlighting
map("n", "<Esc>", ":noh<CR>", opt)

-- Better Indenting ala LunarVim chavales
map("v", "<", "<gv", opt)
map("v", ">", "<gv", opt)

-- Folding ala ntcarlson
map("n", "<Space>", "zA", opt)
map("v", "<Space>", "zA", opt)

-- Insert Current Time in current buffer
map("v", "zM", "<C-R>=strftime('%c')<CR>", opt)

-- Make Y select behave as all Cap letters should
map("v", "Y", "y$", opt)

-- Pairing Braces
map("i", "<>", "<><Left>", opt)

map("i", "()", "()<Left>", opt)

map("i", "[]", "[]<Left>", opt)

map("i", "{}", "{}<Left>", opt)

map("i", "\"\"", "\"\"<Left>", opt)

map("i", "'''", "''<Left>", opt)

map("i", "`", "``<Left>")
map("i", "``", "``<Left>", opt)

map("i", "¿", "¿?<Left>")
map("i", "¿?", "¿?<Left>", opt)

-- Paste and move cursor to newline
map("n", "pp", "p^o<Esc>", opt)

-- Undo Break Points

-- Keep Vim centered

-- Function taken from LunarVim (sort of)
function print_bindings(mode)
	print "List of PikaVim's bindings, sort of"
	if mode then
		print(vim.api.nvim_get_keymap(mode))
	end
end
