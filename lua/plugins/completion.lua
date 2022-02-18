local cmp = require'cmp'

cmp.setup({
    mapping = {
        ['<A-b>'] =  cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    }
})

-- Setup lspconfig.
-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
