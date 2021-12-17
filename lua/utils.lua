local api = vim.api

local utils = {}

-- Function taken from NvimChad
function utils.map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    api.nvim_set_keymap(mode, lhs, rhs, options)
end

function utils.nmap(key, cmd, opts)
  return map("n", key, cmd, opts)
end

function utils.vmap(key, cmd, opts)
  return map("v", key, cmd, opts)
end

function utils.xmap(key, cmd, opts)
  return map("x", key, cmd, opts)
end

function utils.imap(key, cmd, opts)
  return map("i", key, cmd, opts)
end

function utils.omap(key, cmd, opts)
  return map("o", key, cmd, opts)
end

function utils.smap(key, cmd, opts)
  return map("s", key, cmd, opts)
end

return utils
