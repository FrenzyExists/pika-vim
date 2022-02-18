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

-- c-q <vertical highlight what you want>
-- c-a <increment>
-- OR
-- c-q -> g -> <c-a> <highlight and then increment numbers by one>

-- Function taken from NvimChad
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- empty mode is same as using :map
map("", "j", 'v:count ? "j" : "gj"', {expr = true})
map("", "k", 'v:count ? "k" : "gk"', {expr = true})
map("", "<Down>", 'v:count ? "j" : "gj"', {expr = true})
map("", "<Up>", 'v:count ? "k" : "gk"', {expr = true})

-- Save with ctrl+s, like every normal damn editor
map("n", "<c-s>", ":w<cr>", opt)
map("n", "<C-x>", ":wq<CR>", opt)

-- Better Tab Navigation (ala coño)
map("n", "th", ":tabfirst<CR>", opt)
map("n", "tk", ":tabnext<CR>", opt)
map("n", "tj", ":tabprev<CR>", opt)
map("n", "tt", ":tabedit<Space>", opt)
map("n", "tl", ":tablast<CR>", opt)
map("n", "tn", ":tabnew<CR>", opt)
map("n", "td", ":tabclose<CR>", opt)

-- Move between each split faster (speed, I am speed)
map("n", "<A-k>", ":wincmd k<CR>", opt)
map("n", "<A-j>", ":wincmd j<CR>", opt)
map("n", "<A-l>", ":wincmd l<CR>", opt)
map("n", "<A-h>", ":wincmd h<CR>", opt)

-- Maximize Window
map("n", "<A-q>", ":resize<CR>", opt)

-- Better Resizing ala LunarVim (sort of)
map("n", "<C-h>", ":vertical resize +2<CR>", opt)
map("n", "<C-l>", ":vertical resize -2<CR>", opt)
map("n", "<C-j>", ":resize +2<CR>", opt)
map("n", "<C-k>", ":resize -2<CR>", opt)

map("i", "<C-j>", 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = false })
map("i", "<C-k>", 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = false })

-- Better Indenting ala LunarVim chavales
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)

map("n", "<", "<<", opt)
map("n", ">", ">>", opt)

-- Folding ala ntcarlson
map("n", "<Space>", "zA", opt)
map("v", "<Space>", "zA", opt)

-- Make Y select behave as all Cap letters should
map("n", "Y", "y$", opt)

-- Insert Current Time in current buffer
map("n", "zM", "\"=strftime(\"%c\")<CR>P", opt)

-- move the current line/block with Alt-j/k ala VSCode (INSERT)
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opt)
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opt)

-- move the current line/block with Alt-j/k ala VSCode (VISUAL)
map("v", "<A-j>", ":m '>+1<CR>gv=gv", opt)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", opt)

-- For insert mode
map("i", "<C-j>", "<esc>:m '<+1<CR>gv=gv", opt)
map("i", "<C-k>", "<esc>:m '<-2<CR>gv=gv", opt)

-- For normal mode
map("n", "<leader>j", ":m .+1<CR>==", opt)
map("n", "<leader>k", ":m .-2<CR>==", opt)

-- Split faster (fast as fuck boi)
map("n", "<leader>\\", ":vs<CR>", opt)
map("n", "<leader>-", ":sp<CR>", opt)

-- Rotate windows downward rightward
map("n", "<A-r>", ":wincmd r<CR>", opt)
map("n", "<A-R>", ":wincmd R<CR>", opt)

-- toggle numbers
map("n", "<leader>_", ":set nu!<CR>", opt)

-- copy whole file content
map("n", "<C-a>", ":%y+<CR>", opt)

-- open file tree
map("n", "<C-n>", ":NvimTreeToggle<CR>", opt)

-- Pairing Braces
map("i", "<>", "<><Left>", opt)

map("i", "()", "()<Left>", opt)

map("i", "[]", "[]<Left>", opt)

map("i", "{}", "{}<Left>", opt)

map("i", "\"\"", "\"\"<Left>", opt)

map("i", "''", "'<Left>", opt)

map("i", "``", "`<Left>")

map("i", "¿", "¿?<Left>")
map("i", "¿?", "¿?<Left>", opt)

-- Paste and move cursor to newline
map("n", "pp", "p^o<Esc>", opt)

-- Better movement over a single line
map("n",  "L", "$", opt)
map("n",  "H", "^", opt)
map("v",  "L", "$", opt)
map("v",  "H", "^", opt)


-- Add new line bellow without insert mode (ala iBhagwan)
map("n", "<leader>]", ":<C-u>call append(line(\".\"), repeat([\"\"], v:count1))<CR>", opt)
map("v", "<leader>]", ":<C-u>call append(line(\".\"), repeat([\"\"], v:count1))<CR>", opt)

-- Add new line above without insert mode (ala Hello World)
map("n", "<leader>[", ":<c-u>put!=repeat([''],v:count)<bar>']+1<cr>", opt)
map("v", "<leader>[", ":<c-u>put!=repeat([''],v:count)<bar>']+1<cr>", opt)


-- Better Replacing/Searching (ala Jose Ramon Cano)
-- USAGE --
-- Go on top of a word you want to change
-- Press cn or cN
-- Type the new word you want to replace it with
-- Smash that dot '.' multiple times to change all the other occurrences of the word
map("n", "cn", "*``cgn", opt)
map("n", "cN", "*``cgN", opt)

-- Keep lines Centered (ala  ThePrimeagen)
map("n", "n", "nzzzv", opt)
map("n", "N", "Nzzzv", opt)

-- Better Join with line bellow (ala ThePrimeagen)
map("n", "J", "mzJ`z", opt)

-- Better Undo by break point (ala  ThePrimeagen)
map("i", ",", ",<C-g>u", opt)
map("i", ".", ".<C-g>u", opt)
map("i", "!", "!<C-g>u", opt)
map("i", "?", "?<C-g>u", opt)
map("i", "[", "[<C-g>u", opt)

-- Jumplist mutations
map("n", "<expr>k", "(v:count > 5 ? \"m\" . v:count : \"\") . 'k'", opt)
map("n", "<expr>j", "(v:count > 5 ? \"m\" . v:count : \"\") . 'j'", opt)

-- Paste and join lower line
map("x",  "<leader>p", "\"_dP", opt)

-- Better Yanks
map("v", "<leader>y", "\"+y", opt)
map("n", "<leader>Y", "gg\"+yG", opt)

--"replace all instances of word under cursor (ala Michael Carnevale)
map("n", "<leader>S", ":%s/<C-r><C-w>//g<Left><Left>", opt)

--"replace all instances of highlighted characters (ala Michael Carnevale)
map("v", "S", "\"hy:%s/<C-r>h//g<left><left>", opt)

-- Word count (lua translation ala Raphael)
map("v", "<leader>la", ":s/\\S\\+//gn<CR>", opt)

-- g<C-g><CR>


-- Function taken from LunarVim (sort of)
 function print_bindings(mode)
    print("List of PikaVim's bindings, sort of")
 	if mode then
 		print(vim.api.nvim_get_keymap(mode))
 	end
 end
