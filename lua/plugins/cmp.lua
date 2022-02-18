-- https://github.com/hrsh7th/nvim-cmp
local cmp = require('cmp')
local luasnip = require('luasnip')

local cmp_kinds = {
    Class = ' ',
    Color = ' ',
    Constant = 'ﲀ ',
    Constructor = ' ',
    Enum = '練',
    EnumMember = ' ',
    Event = ' ',
    Field = ' ',
    File = '',
    Folder = ' ',
    Function = ' ',
    Interface = 'ﰮ ',
    Keyword = ' ',
    Method = ' ',
    Module = ' ',
    Operator = '',
    Property = ' ',
    Reference = ' ',
    Snippet = ' ', Struct = ' ',
    Text = ' ',
    TypeParameter = ' ',
    Unit = '塞',
    Value = ' ',
    Variable = ' ',
}

require('luasnip.loaders.from_vscode').lazy_load()
vim.api.nvim_command('hi LuasnipChoiceNodePassive cterm=italic')

vim.opt.completeopt = 'menu,menuone,noselect'

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = string.format('%s %s', cmp_kinds[vim_item.kind], vim_item.kind)
            vim_item.menu = ({
                nvim_lsp = '[Lsp]',
                luasnip = '[Snp]',
                buffer = '[Buf]',
                nvim_lua = '[Lua]',
                path = '[Pth]',
                calc = '[Clc]',
                emoji = '[Emj]',
                rg = '[Rg]',
            })[entry.source.name]

            return vim_item
        end,
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end,
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'nvim_lua' },
    }, {
        { name = 'buffer' },
        { name = 'path' },
        { name = 'rg' },
    }),
})

local types = require("luasnip.util.types")

require'luasnip'.config.setup({
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = {{"●", "GruvboxOrange"}}
			}
		},
		[types.insertNode] = {
			active = {
				virt_text = {{"●", "GruvboxBlue"}}
			}
		}
	},
})




local current_nsid = vim.api.nvim_create_namespace("LuaSnipChoiceListSelections")
local current_win = nil

local function window_for_choiceNode(choiceNode)
    local buf = vim.api.nvim_create_buf(false, true)
    local buf_text = {}
    local row_selection = 0
    local row_offset = 0
    local text
    for _, node in ipairs(choiceNode.choices) do
        text = node:get_docstring()
        -- find one that is currently showing
        if node == choiceNode.active_choice then
            -- current line is starter from buffer list which is length usually
            row_selection = #buf_text
            -- finding how many lines total within a choice selection
            row_offset = #text
        end
        vim.list_extend(buf_text, text)
    end

    vim.api.nvim_buf_set_text(buf, 0,0,0,0, buf_text)
    local w, h = vim.lsp.util._make_floating_popup_size(buf_text)

    -- adding highlight so we can see which one is been selected.
    local extmark = vim.api.nvim_buf_set_extmark(buf,current_nsid,row_selection ,0,
        {hl_group = 'incsearch',end_line = row_selection + row_offset})

    -- shows window at a beginning of choiceNode.
    local win = vim.api.nvim_open_win(buf, false, {
        relative = "win", width = w, height = h, bufpos = choiceNode.mark:pos_begin_end(), style = "minimal", border = 'rounded'})

    -- return with 3 main important so we can use them again
    return {win_id = win,extmark = extmark,buf = buf}
end

function choice_popup(choiceNode)
	-- build stack for nested choiceNodes.
	if current_win then
		vim.api.nvim_win_close(current_win.win_id, true)
                vim.api.nvim_buf_del_extmark(current_win.buf,current_nsid,current_win.extmark)
	end
        local create_win = window_for_choiceNode(choiceNode)
	current_win = {
		win_id = create_win.win_id,
		prev = current_win,
		node = choiceNode,
                extmark = create_win.extmark,
                buf = create_win.buf
	}
end

function update_choice_popup(choiceNode)
    vim.api.nvim_win_close(current_win.win_id, true)
    vim.api.nvim_buf_del_extmark(current_win.buf,current_nsid,current_win.extmark)
    local create_win = window_for_choiceNode(choiceNode)
    current_win.win_id = create_win.win_id
    current_win.extmark = create_win.extmark
    current_win.buf = create_win.buf
end

function choice_popup_close()
	vim.api.nvim_win_close(current_win.win_id, true)
        vim.api.nvim_buf_del_extmark(current_win.buf,current_nsid,current_win.extmark)
        -- now we are checking if we still have previous choice we were in after exit nested choice
	current_win = current_win.prev
	if current_win then
		-- reopen window further down in the stack.
                local create_win = window_for_choiceNode(current_win.node)
                current_win.win_id = create_win.win_id
                current_win.extmark = create_win.extmark
                current_win.buf = create_win.buf
	end
end

vim.cmd([[
augroup choice_popup
au!
au User LuasnipChoiceNodeEnter lua choice_popup(require("luasnip").session.event_node)
au User LuasnipChoiceNodeLeave lua choice_popup_close()
au User LuasnipChangeChoice lua update_choice_popup(require("luasnip").session.event_node)
augroup END
]])

